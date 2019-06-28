# iOSAppArchitecture

iOS app architecture we use.

MVPCF = Model View Presenter Coordinator Factory;

It is similar to combination of Reactive MVP + Coordinator + Factory.
Presenter is the same thing like ViewModel in MVVM, but it has different name.
ViewModel name uses for different approach;

SOLID principles are a core of our architecture.

For our architecture we created pretty simple and small library [RCKit](https://github.com/wolvesstudio/RCKit) aka Reactive Clean Kit, that contains all we need for building app using this architecture.

1. For assembling project we use DI pattern with [Swinject](https://github.com/Swinject/Swinject) library.

App has shared [Container](https://github.com/Swinject/Swinject/blob/master/Documentation/DIContainer.md) where we register all shared dependencies we need to use across all app.

2. Project divided on Flows

Every flow has his own folder.
Every flow has his "manager" called [Coordinator](https://github.com/wolvesstudio/RCKit/blob/master/Sources/RCKit/Coordinator/Coordinator.swift).
Every flow has his own DI [Container](https://github.com/Swinject/Swinject/blob/master/Documentation/DIContainer.md) that contains specific dependencies for flow.

This object is responsible for handling navigation through the application, handling push notifications and other routing actions.

Coordinator uses 1 container viewcontroller like (UINavigationController/ UISplitViewController)

Coordinator builds screens (Modules) and controls flow.

1 exception is main ApplicationCoordinator which accepts UIWindow instead of container.

3. Every Module for [example](https://github.com/wolvesstudio/iOSAppArchitecture/tree/master/AppArchitecture/Flows/MainMenuFlow/List) has following structure:

- <Name>Factory - abstraction for creation anything. Factory is very important part of this architecture, because it injects dependencies. [BaseFactory](https://github.com/wolvesstudio/RCKit/blob/master/Sources/RCKit/BaseFactory.swift) contains Container we use to inject dependencies we need. Factory can be used for Modules, as well for building Cells, NSOperations and etc where we need to inject something. We can inject factories where we need, and it gives us a lot of flexibility!
  
```swift
  protocol <Name>Factory {
    func make()-> <Name>Routes
  } 
```
- <Name>Routes - abstraction for Routes of the Module. ViewController implements this protocol.
 Closures fire in Coordinator, and Coordinator perform what needs.
 ```swift
    protocol <Name>Routes: ModuleRoutes {
      var canceled: (()->Void)! { get set }
      var finished: ((String)->Void)! { get set }
    }
  ```
 
 - <Name>Presenter - abstraction for Presenter. It has default implementation.
  It contains logic of presentation. It has bindings for input and output.
  Presenter contains structures called (ViewModels) as well as plain types, ready to use in View. 
 
 ```swift
 
 // for example
 struct <SomeCell>ViewModel {
    let name: String 
    let dateFormatter: String 
 }
 
  protocol <Name>Presenter {
    var searchInput: BehaviorRelay<String?> { get }
    var searchResults: BehaviorRelay<[<SomeCell>ViewModel]> { get }
    var nextButtonAvailable: BehaviorRelay<Bool> { get }
  }
  ```
  
  - <Name>View - abstraction for view. It has default implementation inherited from UIView.
  
  It contains custom view for ViewController.
  
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
  
  
  4. Every Presenter's implementation injects Logic it needs.
  
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
  
- MVVM and MVP. MVPCF uses (MVVM and MVP) as a base architecture, and improves both with coordinators and factories.

- VIPER. It has Presenter as main Object of module, as well Router is not Obvious. 
  MVPCF has ViewController as main object of module, and Coordinator which handle navigation. 
  As well standard VIPER is not reactive from the box.
  
- RIBs. Interactor in RIBs is main object of module, but MVPCF has ViewController as main object. 
  Our approach are more obvious for typical developers
  
  
  
  
  
  
  





