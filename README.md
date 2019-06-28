# iOSAppArchitecture
iOS app architecture example based on Clean Architecture.

Repositorory doesn't have xcodeproj. It uses project.yml and Xcodegen utility.

MVPCF - it is like Reactive MVP + Coordinator + Factory.
Presenter is the same thing like ViewModel in MVVM, but different naming.
ViewModel name uses for different approaches;

Every app we build using SOLID principles;

It is crucial thing to achvieve clean and flexible architecture;

1. For assembling project we use DI pattern with [Swinject] library.

App has shared [Container] where we register all shared dependencies we need to use across all app.

2. Project divided on Flows

Every flow has his own folder.
Every flow has his "manager" called Coordinator.
Every flow has his own DI [Container] that contains specific dependencies for flow.

This object is responsible for handling routing in the application, handling push notifications and other routing actions.

Coordinator use 1 container viewcontroller like (UINavigationController/ UISplitViewController)

Coordinator builds screens (Modules) and controls flow.

1 exception is main ApplicationCoordinator which accepts UIWindow instead of container.

3. Every Module has following structure

- <Name>Factory - abstraction for create Module. It has default implementation
  
```swift
  protocol <Name>Factory {
    func make()-> <Name>Routes
  } 
```
- <Name>Routes - abstraction for Routes of this Module. It has implementation ViewController.
 Closures fire in Coordinator, and Coordinator perform what needs.
 ```swift
    protocol <Name>Routes: ModuleRoutes {
      var canceled: (()->Void)! { get set }
      var finished: ((String)->Void)! { get set }
    }
  ```
 
 - <Name>Presenter - abstraction for Presenter. It has default implementation.
  It contains logic of presentation. Ith as bindings for input and output.
 
 ```swift
  protocol <Name>Presenter {
    var name: BehaviorRelay<String?> { get }
    var addButtonAvailable: BehaviorRelay<Bool> { get }
  }
  ```
  
  - <Name>View - abstraction over view. It has default implementation inherited from UIView.
  
  Contains custom view for ViewController.
  
  ```swift
    protocol <Name>View: ViewContainer {
      var addButton: UIButton { get }
      var textField: UITextField { get }
    }
  ```
  
 - <Name>ViewController 
  ViewController itself. Inherired from UIViewController Implements Routes protocol.
  
  It is responsible for
  - bind Presenter to View
  - registering for events like button tap 
  - firing Routes closures. 
  Basically the main building structure of screens.
  
  
  
  4. Every Presenter injects Logic it needs.
  
  ```swift
  class Default<Name>Presenter: <Name>Presenter{
    
    let name: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    let addButtonAvailable: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    private var creating = BehaviorRelay(value: false)
    private var disposable: Disposable?
    private let disposeBag = DisposeBag()
    private let modelManager: ModelManager
    private let reachabilityManager: ReachabilityManager
    
    // injecting via initializer
    init(modelManager: ModelManager, reachabilityManager: ReachabilityManager){
        self.modelManager = modelManager
        self.reachabilityManager = reachabilityManager
    }
  }
  
  ```
  
  Every Logic unit should have only 1 responsility!
  It is very important thing to achieve flexibility!
  
  For example:
  
  ```swift
  
  protocol ReachabilityManager {
    var connectionIsReachable: BehaviorRelay<Bool> { get }
  }
  
  ```
  Or this: 
  ```swift
  protocol FirstLaunchManager {
    func performTasksOnFirstLaunch()
  }
  ```
  
  Or this: 
  ```swift 
  protocol LogoutManager {
    func logout()
  }
  ```
  
  5. Differences from other architectures.
  
  - MVVM and MVP 
  Our architecture used that one as a base architecture and improved with coordinators and factories.
  - VIPER 
  VIPER has Presenter as main Object of module, as well Router is not Obvious. 
  We have ViewController as main object of module, and Coordinator which handle routing. As well standard VIPER is not      reactive from the box.
  - RIBs
  Interactor in RIBs is main object of module, but we have VC as main object. Our approach are more obvious for typical developers
  
  
  
  
  
  
  





