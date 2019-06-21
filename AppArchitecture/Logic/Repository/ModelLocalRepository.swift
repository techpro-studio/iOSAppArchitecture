//
//  ModelLocalRepository.swift
//  example
//
//  Created by Alex on 4/8/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RCKit
import RCRealm


protocol ModelLocalRepository {
    func getList()->LazyContainer<Model>
    func save(value:Model)
    func getById(id:String)->Model?
    func saveMany(value: [Model])
}
