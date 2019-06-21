//
//  ListViewFactory.swift
//  example
//
//  Created by Alex on 4/8/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RCKit


protocol ListFactory {
    func make() -> ListRoutes
}




class DefaultListFactory: BaseFactory, ListFactory {
    
    func make() -> ListRoutes {
        return ListViewController(
            presenter: DefaultListViewPresenter(reachabilityManager: container.resolve(ReachabilityManager.self)!, modelManager: container.resolve(ModelManager.self)!),
            view: DefaultListView()
        )
    }
}
