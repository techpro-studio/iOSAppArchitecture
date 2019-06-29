# iOSAppArchitecture

iOS app architecture we use.

MVPCF = Model View Presenter Coordinator Factory;

It is similar to the combination of Reactive MVP + Coordinator + Factory.
Presenter is the same thing as ViewModel in MVVM but it has a different name.
ViewModel name is used for a different approach;

SOLID principles are the core of our architecture.

For our architecture, we created a pretty simple and small library [RCKit](https://github.com/wolvesstudio/RCKit) aka Reactive Clean Kit, that contains everything we need for building an app using this architecture.

## 1. For assembling project we use DI pattern with [Swinject](https://github.com/Swinject/Swinject) library.

App has shared [Container](https://github.com/Swinject/Swinject/blob/master/Documentation/DIContainer.md) where we register all shared dependencies we need to use across the whole app.

## 2. Project is divided up into Flows

Every flow has its own folder.
Every flow has its "manager" called [Coordinator](https://github.com/wolvesstudio/RCKit/blob/master/Sources/RCKit/Coordinator/Coordinator.swift).
Every flow has its own DI [Container](https://github.com/Swinject/Swinject/blob/master/Documentation/DIContainer.md) that contains specific dependencies for the flow.

This object is responsible for handling navigation through the application, handling push notifications, and other routing actions.

Coordinator uses one container viewcontroller like UINavigationController or UISplitViewController.

Coordinator builds the screens (Modules) and controls the flow.

The only exception is a main ApplicationCoordinator that accepts UIWindow instead of container ViewController.

## 3. Every Module for [example](https://github.com/wolvesstudio/iOSAppArchitecture/tree/master/AppArchitecture/Flows/MainMenuFlow/List) has the following structure:

### Factory 
  Abstraction for creation anything. Factory is very important part of this architecture, because it injects dependencies. [BaseFactory](https://github.com/wolvesstudio/RCKit/blob/master/Sources/RCKit/BaseFactory.swift) contains Container we use to inject dependencies that we need. Factory can be used for Modules as well as building Cells, NSOperations, etc where we need to inject something. We can inject factories where we need and it gives us a lot of flexibility!
  
```swift
  protocol <Name>Factory {
    func make()-> <Name>Routes
  } 
```
### Routes
Abstraction for Routes of the Module. ViewController implements this protocol.
 Closures fire in Coordinator and Coordinator performs what is needed.
 ```swift
    protocol <Name>Routes: ModuleRoutes {
      var canceled: (()->Void)! { get set }
      var finished: ((String)->Void)! { get set }
    }
  ```
 
### Presenter
 Abstraction for Presenter. It has default implementation.
  It contains a logic of the presentation. It has the bindings for input and output.
  Presenter contains structures called ViewModel as well as plain types, ready to use in View. 
 
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
  
### View 
Abstraction for view. It has default implementation inherited from UIView.
  
  It contains custom view for ViewController.
  
  ```swift
    protocol <Name>View: ViewContainer {
      var addButton: UIButton { get }
      var textField: UITextField { get }
    }
  ```
  
### ViewController
Inherired from UIViewController Implements Routes protocol.
  
  It is responsible for:
  - binding Presenter to View;
  - registering for events as a button tap; 
  - firing Routes closures. 
  Basically it is the main building structure of screens.
  
  
  ## 4. Every Presenter's implementation injects units it needs.
  
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
  
  Every unit should have only one responsibility!
  
  
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
  
 ## 5. Differences from the other architectures.
  
- MVVM and MVP. MVPCF uses MVVM and MVP as a base architecture and improves both with coordinators and factories;

- VIPER. It has a Presenter as the main Object of the module. Router is not Obvious. 
  MVPCF has ViewController as the main object of the module and Coordinator that handles the navigation. 
  Also, standard VIPER is not reactive from the box.
  
- RIBs. Interactor in RIBs is the main object of module, but MVPCF has ViewController as the main object. 
  Our approach is more obvious for typical developers.
  
  
  
  
  
  
  





