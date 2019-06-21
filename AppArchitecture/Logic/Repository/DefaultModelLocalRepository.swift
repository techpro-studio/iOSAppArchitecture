//
//  DefaultModelLocalRepository.swift
//  example
//
//  Created by Alex on 4/9/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RCKit
import RCRealm

class DefaultModelLocalRepository: BaseRealmRepository<Model>, ModelLocalRepository{
    
    func getList() -> LazyContainer<Model> {
        return self.getContainer(sort: nil)
    }
    
}
