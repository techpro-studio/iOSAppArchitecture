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


struct DefaultDetailFactory:  DetailFactory {
    let modelManager: ModelManager

    func make(id: String) -> DetailRoutes {
        let presenter = DefaultDetailPresenter(modelManager: modelManager)
        presenter.setup(id: id)
        let viewController = DetailViewController(presenter: presenter, view: DefaultDetailView())
        return viewController
    }
}
