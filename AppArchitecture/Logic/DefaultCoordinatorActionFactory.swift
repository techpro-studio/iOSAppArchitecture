//
//  DefaultCoordinatorActionFactory.swift
//  example
//
//  Created by Alex on 4/7/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RCKit
import UserNotifications



class DefaultCoordinatorActionFactory: CoordinatorActionFactory{
   
    func make(from userActivity: NSUserActivity?) -> CoordinatorAction? {
        return nil
    }
    
    func make(from launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> CoordinatorAction? {
        return nil
    }
    
    func make(from notification: [AnyHashable : Any]?) -> CoordinatorAction? {
        return nil
    }
    
    func make(from shortcutItem: UIApplicationShortcutItem) -> CoordinatorAction? {
        return nil
    }
    
    @available(iOS 10.0, *)
    func make(from response: UNNotificationResponse?) -> CoordinatorAction? {
        return nil
    }
    
}
