//
//  DefaultModelRemoteRepository.swift
//  example
//
//  Created by Alex on 4/8/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RCKit
import RxSwift


// just mocks;

class DefaultModelRemoteRepository: DefaultBaseRemoteRepository, ModelRemoteRepository {
    func getOne(id: String) -> Observable<Model> {
        return Observable.just(Model(id: id, name: UUID().uuidString)).delay(.init(floatLiteral: 0.5), scheduler: MainScheduler.instance)
    }
    
    func getNew() -> Observable<[Model]> {
        return Observable.just([Model(id: UUID().uuidString, name: "New one")]).delay(.init(floatLiteral: 0.5), scheduler: MainScheduler.instance)
    }
    
    func createOne(id: String, name: String) -> Observable<Model> {
        return Observable.just(Model(id: id, name: name)).delay(.init(floatLiteral: 0.5), scheduler: MainScheduler.instance)
    }
}
