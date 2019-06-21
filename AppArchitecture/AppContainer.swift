//
//  AppContainer.swift
//  example
//
//  Created by Alex on 4/7/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import Swinject
import RCKit


func buildAppContainer(container: Container){
    
    container.register(KeyValueStorage.self) { (_) -> KeyValueStorage in
        return UserDefaults.standard
    }
    
    container.register(AppStateManager.self) { (_) -> AppStateManager in
        return DefaultAppStateManager()
    }
    
    container.register(CoordinatorActionFactory.self) { (resolver) -> CoordinatorActionFactory in
        return DefaultCoordinatorActionFactory()
    }
    
    container.register(ReachabilityManager.self) { (resolver) -> ReachabilityManager in
        return DefaultReachabilityManager(appStateManager: resolver.resolve(AppStateManager.self)!)
    }
    
    container.register(PreferencesManager.self) { (resolver) -> PreferencesManager in
        return DefaultPreferenceManager(storage: resolver.resolve(KeyValueStorage.self)!)
    }.inObjectScope(ObjectScope.container)
    
}
