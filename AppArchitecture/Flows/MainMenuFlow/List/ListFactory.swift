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




struct DefaultListFactory: ListFactory {

    let modelManager: ModelManager
    let reachabilityManager: ReachabilityManager
    
    func make() -> ListRoutes {
        return ListViewController(
            presenter: DefaultListViewPresenter(reachabilityManager: reachabilityManager, modelManager: modelManager),
            view: DefaultListView()
        )
    }
}
