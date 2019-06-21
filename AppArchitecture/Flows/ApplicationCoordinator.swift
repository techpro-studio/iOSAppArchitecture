//
//  ApplicationCoordinator.swift
//  example
//
//  Created by Alex on 4/7/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RCKit
import Swinject

class ApplicationCoordinator: BaseCoordinator{
    
    unowned let window: UIWindow
    
    private lazy var preferenceManager = self.container.resolve(PreferencesManager.self)!
    
    init(window: UIWindow, container: Container){
        self.window = window
        super.init(container: container)
    }
    
    
    override func process(action: CoordinatorAction?) {
        // here we can handle actions performed from different sources
    }
    
    override func start() {
        
        let token:String?  = self.preferenceManager[.authToken]
        if (token == nil){
            let mainMenuCoordinator = MainMenuCoordinator(window: self.window, container: self.container)
            
            self.addDependency(mainMenuCoordinator)
            
            mainMenuCoordinator.start()
        }
        
    }
}
