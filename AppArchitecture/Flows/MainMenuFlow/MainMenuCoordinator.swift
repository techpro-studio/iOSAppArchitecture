//
//  MainMenuCoordinator.swift
//  example
//
//  Created by Alex on 4/7/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RCKit
import Swinject


class MainMenuCoordinator: BaseCoordinator{
    
    
    unowned let window: UIWindow
    
    private let navigationController = UINavigationController()
    
    init(window: UIWindow, container: Container){
        self.window = window
        self.window.rootViewController = navigationController
        super.init(container: buildMainMenuContainer(parent: container))
    }
    
    
    override func start() {
        runList()
    }
    
    func runList(){
        let listView = self.container.resolve(ListFactory.self)!.make()
        
        listView.showDetail = {[weak self] id in
            self?.showDetail(id: id)
        }
        
        listView.addNewOne = {[weak self] in
            self?.runAdd()
        }
    self.navigationController.setViewControllers([listView.viewController], animated: false)
    }
    
    func showDetail(id:String){
        let detailView = self.container.resolve(DetailFactory.self)!.make(id: id)
        self.navigationController.show(detailView.viewController, sender: nil)
    }
    
    
    func runAdd(){
        let addOneCoordinator = AddOneCoordinator(source: self.navigationController, container: self.container)
        
        addOneCoordinator.finished = {[weak self, weak addOneCoordinator] idOpt in
            self?.removeDependency(addOneCoordinator)
            if let id = idOpt{
                self?.showDetail(id: id)
            }
        }
        
        self.addDependency(addOneCoordinator)
        
        addOneCoordinator.start()
    }
    
}
