//
//  BasicNetworkController.swift
//  ControllerPattern
//
//  Created by Mehdi Gilanpour on 1/28/22.
//

import UIKit
import SystemConfiguration

protocol ApiClient {
    func execute<T>(request: BasicRequestModel, completionHandler: @escaping (_ result: Result<BasicResponseModel<T>>) -> Void)
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

class BasicNetworkController: ApiClient {
    let urlSession: URLSessionProtocol
    var dataTask: URLSessionDataTask!
    
    init(urlSessionConfiguration: URLSessionConfiguration, completionHandlerQueue: OperationQueue) {
        urlSession = URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: completionHandlerQueue)
    }
    
    // This should be used mainly for testing purposes
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    func convertToDictionary(_ jsonString: String) -> [String: Any]? {
        if let data = jsonString.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    // MARK: - ApiClient
    
    fileprivate func done<T>(request: BasicRequestModel, data: Data?, response: URLResponse?, error: Error?, completionHandler: @escaping (Result<BasicResponseModel<T>>) -> Void) {
        guard let httpUrlResponse = response as? HTTPURLResponse else {
            completionHandler(.failure(CoreError(message: error?.localizedDescription ?? "")))
            return
        }
        
        if let data = data, let utf8Text = String(data: data, encoding: .utf8) {
            let jsonData = convertToDictionary(utf8Text)
            if let jsonData = jsonData {
                do {
                    let json = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                    let response = try BasicResponseModel<T>(data: json, httpUrlResponse: httpUrlResponse)
                    completionHandler(.success(response))
                } catch {
                    completionHandler(.failure(CoreError(message: "")))
                }
            } else {
                if let error = error {
                    completionHandler(.failure(CoreError(message: error.localizedDescription)))
                } else {
                    completionHandler(.failure(CoreError(statusCode: httpUrlResponse.statusCode, message: "Error in fetching data")))
                }
            }
        } else {
            if let error = error {
                completionHandler(.failure(CoreError(message: error.localizedDescription)))
            } else {
                completionHandler(.failure(CoreError(statusCode: httpUrlResponse.statusCode, message: "Error in fetching data")))
            }
        }
    }
    
    func execute<T>(request: BasicRequestModel, completionHandler: @escaping (Result<BasicResponseModel<T>>) -> Void) {
        if isInternetAvailable() {
            #if DEBUG
            print("request URL: ", request.urlRequest.url?.absoluteString ?? "")
            #endif
            
            dataTask = urlSession.dataTask(with: request.urlRequest) { (data, response, error) in
                self.done(request: request, data: data, response: response, error: error, completionHandler: completionHandler)
            }
            
            dataTask.resume()
        } else {
            completionHandler(.failure(CoreError(statusCode: 100, message: "Check the internet connection")))
        }
    }
    
    @objc func cancel() {
        dataTask.cancel()
    }
    
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        if let dR = defaultRouteReachability {
            var flags = SCNetworkReachabilityFlags()
            if !SCNetworkReachabilityGetFlags(dR, &flags) {
                return false
            }
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            return (isReachable && !needsConnection)
        }
        return false
    }
    
}
