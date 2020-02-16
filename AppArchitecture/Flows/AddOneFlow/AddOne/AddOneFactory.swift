//
//  AddOneViewFactory.swift
//  example
//
//  Created by Alex on 4/10/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RCKit

protocol AddOneFactory {
    func make()->AddOneRoutes
}




struct DefaultAddOneFactory: AddOneFactory{

    let modelManager: ModelManager
    let reachabilityManager: ReachabilityManager

    func make() -> AddOneRoutes {
        return AddOneViewController(
            presenter: DefaultAddOnePresenter(modelManager: modelManager, reachabilityManager: reachabilityManager),
            viewContainer: DefaultAddOneView()
        )
    }
}
