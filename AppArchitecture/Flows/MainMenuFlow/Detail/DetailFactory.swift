//
//  DetailViewFactory.swift
//  example
//
//  Created by Alex on 4/9/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RCKit

protocol DetailFactory {
    func make(id:String)->DetailRoutes
}


class DefaultDetailFactory: BaseFactory, DetailFactory {

    func make(id: String) -> DetailRoutes {
        let presenter = DefaultDetailPresenter(modelManager: container.resolve(ModelManager.self)!)
        presenter.setup(id: id)
        let viewController = DetailViewController(presenter: presenter, view: DefaultDetailView())
        return viewController
    }
}
