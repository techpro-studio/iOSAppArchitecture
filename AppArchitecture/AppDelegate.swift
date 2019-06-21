//
//  AppDelegate.swift
//  example
//
//  Created by Alex on 4/6/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit
import Swinject
import RCKit
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let container = Container()
    
    private var applicationCoordinator: ApplicationCoordinator!
    
    lazy var actionFactory: CoordinatorActionFactory = self.container.resolve(CoordinatorActionFactory.self)!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible();
        window?.backgroundColor = .white
        
        buildAppContainer(container: container)
        
        applicationCoordinator = ApplicationCoordinator(window: self.window!, container: self.container)
        
        applicationCoordinator.start()
        
        applicationCoordinator.process(action: self.actionFactory.make(from: launchOptions))
        
        return true
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        applicationCoordinator.process(action: self.actionFactory.make(from: response))
        completionHandler()
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let action = self.actionFactory.make(from: shortcutItem)
        applicationCoordinator.process(action: action)
        completionHandler(action != nil)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        applicationCoordinator.process(action: self.actionFactory.make(from: userInfo))
    }



}

