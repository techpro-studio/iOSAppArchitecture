//
//  AddOneContainer.swift
//  example
//
//  Created by Alex on 4/10/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import Swinject
import RCKit

func buildAddOneContainer(parent: Container)->Container{
    let container = Container(parent: parent)
    
    container.register(AddOneFactory.self) { (resolver) -> AddOneFactory in
        return DefaultAddOneFactory(modelManager: resolver.resolve(ModelManager.self)!, reachabilityManager: resolver.resolve(ReachabilityManager.self)!)
    }
    
    return container
}
