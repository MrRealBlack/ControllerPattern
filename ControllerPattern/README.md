# ControllerPattern
A simple and powerful design pattern for iOS apps

### Run Requirements

* Xcode 12
* Swift 5

#### Controller Pattern Concepts
The main goal from bring up this pattern is dividing layers as simplest way I can. Main layers are just `View` and `Logic` or `ViewController` and `LogicController`. ViewController has just one responsibility: Modifing the view.
The main layer is LogicController that has as many controllers as it needs. Each controller has a responsibility and is seperate from antoher controller.

### High Level Layers

* `ViweController` - delegates user interaction events to the `LogicController` and displays data passed by the `LogicController`
    * All `UIViewController`, `UIView`, `UITableViewCell` subclasses belong to the `View` layer
    * Usually the view is passive / dumb - it shouldn't contain any complex logic and that's why most of the times we don't need write Unit Tests for it
* `LogicController` - contains the presentation logic and tells the `ViewController` what to present
    * Usually we have one `LogicController` per scene (view controller)
    * It doesn't reference the concrete type of the `View`, but rather it references the `View` protocol that is implemented usually by a `UIViewController` subclass
    * It should be a plain `Swift` class and not reference any `iOS` framework classes - this makes it easier to reuse it maybe in a `macOS` application
    * It should be covered by Unit Tests
    
    
### Low Level Controllers

* `RoutingController` - contains navigation / flow logic from one scene (view controller) to another
* `NetworkController` - contains communication codes with server side. You can use any network dependencies here or keep it pure and work with Swift as well.
* `CoreDataController` - contains codes that can handle CoreData enteties properly.

and other controllers like BluetoothController, SocketController and ....

### Contributing

Please feel free to open an issue for any questions or suggestions you have!
