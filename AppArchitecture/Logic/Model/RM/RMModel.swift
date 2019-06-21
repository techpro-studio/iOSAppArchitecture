//
//  RMModel.swift
//  example
//
//  Created by Alex on 4/8/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RealmSwift
import RCKit
import RCRealm

class RMModel: Object{
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    
    override class func primaryKey()->String{
        return "id"
    }
}


extension RMModel: DomainConvertibleType{
    
    func asDomain() -> Model {
        return Model(id: self.id, name: self.name)
    }
    
}


extension Model: RealmRepresentable{
    
    func asRealm() -> RMModel {
        let model  = RMModel()
        model.id = self.id
        model.name = self.name
        return model
    }
}
