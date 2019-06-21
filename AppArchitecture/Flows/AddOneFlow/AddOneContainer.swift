//
//  AddOneContainer.swift
//  example
//
//  Created by Alex on 4/10/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import Swinject

func buildAddOneContainer(parent: Container)->Container{
    let container = Container(parent: parent)
    
    container.register(AddOneFactory.self) { (resolver) -> AddOneFactory in
        return DefaultAddOneFactory(container: resolver as! Container)
    }
    
    return container
}
