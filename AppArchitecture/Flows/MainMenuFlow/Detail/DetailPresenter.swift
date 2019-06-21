//
//  DetailPresenter.swift
//  example
//
//  Created by Alex on 4/9/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailPresenter {
    var model: BehaviorRelay<Model?> { get }
    func refresh()
    func setup(id:String)
}


class DefaultDetailPresenter: DetailPresenter{
    
    private var id: String!
    
    private let disposeBag = DisposeBag()
    
    private let modelManager: ModelManager
    
    private var disposable: Disposable?
    
    init(modelManager: ModelManager){
        self.modelManager = modelManager
    }
    
    var model: BehaviorRelay<Model?> = BehaviorRelay(value: nil)
    
    func refresh() {
        self.disposable?.dispose()
        self.disposable = self.modelManager.refreshOne(id: self.id).subscribe()
    }
    
    func setup(id: String) {
        self.id = id
        self.model.accept(self.modelManager.getOneLocal(id: id))
    }
    
    deinit {
        disposable?.dispose()
    }
}
