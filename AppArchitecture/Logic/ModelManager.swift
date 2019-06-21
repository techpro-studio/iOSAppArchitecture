//
//  ModelManager.swift
//  example
//
//  Created by Alex on 4/8/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RxSwift
import RCKit
import RCRealm

protocol ModelManager {
    func createOne(name:String)->Observable<Model>
    func sync()->Observable<Void>
    func getOneLocal(id:String)->Model?
    func getAll()->LazyContainer<Model>
    func refreshOne(id:String)->Observable<Void>
}





class DefaultModelManager: ModelManager{
    
    private let modelRemoteRepository: ModelRemoteRepository
    private let modelLocalRepository: ModelLocalRepository
    
    init(modelLocalRepository: ModelLocalRepository, modelRemoteRepository: ModelRemoteRepository){
        self.modelLocalRepository = modelLocalRepository
        self.modelRemoteRepository = modelRemoteRepository
    }
    
    func createOne(name: String) -> Observable<Model> {
        return self.modelRemoteRepository.createOne(id: UUID().uuidString, name: name).map({ [weak self] new in
            self?.modelLocalRepository.save(value: new)
            return new
        })
    }
    
    func sync() -> Observable<Void> {
       return self.modelRemoteRepository.getNew().map({[weak self] new in
            self?.modelLocalRepository.saveMany(value: new)
       })
    }
    
    func getAll() -> LazyContainer<Model> {
        return self.modelLocalRepository.getList()
    }
    
    func getOneLocal(id: String) -> Model? {
        return self.modelLocalRepository.getById(id:id)
    }
    
    func refreshOne(id: String) -> Observable<Void> {
        return self.modelRemoteRepository.getOne(id: id).map({[weak self] updated in
            self?.modelLocalRepository.save(value: updated)
        })
    }
    
}
