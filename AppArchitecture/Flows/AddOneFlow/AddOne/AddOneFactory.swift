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




class DefaultAddOneFactory: BaseFactory,  AddOneFactory{

    func make() -> AddOneRoutes {
        return AddOneViewController(
            presenter: DefaultAddOnePresenter(modelManager: container.resolve(ModelManager.self)!, reachabilityManager: container.resolve(ReachabilityManager.self)!),
            viewContainer: DefaultAddOneView()
        )
    }
}
