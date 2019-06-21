//
//  AddOnePresenter.swift
//  example
//
//  Created by Alex on 4/10/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RxSwift
import RCKit
import RxCocoa


protocol AddOnePresenter {
    var name: BehaviorRelay<String?> { get }
    var addButtonAvailable: BehaviorRelay<Bool> { get }
    func create(completionHandler: @escaping (String)->Void)
}




class DefaultAddOnePresenter: AddOnePresenter{
    
    let name: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    let addButtonAvailable: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    private var creating = BehaviorRelay(value: false)
    private var disposable: Disposable?
    private let disposeBag = DisposeBag()
    private let modelManager: ModelManager
    private let reachabilityManager: ReachabilityManager
    
    init(modelManager: ModelManager, reachabilityManager: ReachabilityManager){
        self.modelManager = modelManager
        self.reachabilityManager = reachabilityManager
        self.computeObservables()
    }
    
    
    func computeObservables(){
        Observable.combineLatest(self.reachabilityManager.connectionIsReachable.asObservable(), self.name.asObservable(), self.creating.asObservable()) { (reachable, name, creating) -> Bool in
            if !(reachable){
                return false
            }
            if creating{
                return false
            }
            
            if (name?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "").isEmpty {
                return false
            }
            
            return true
        }.bind(to: self.addButtonAvailable).disposed(by: self.disposeBag)
    }
    
    func create(completionHandler: @escaping (String) -> Void) {
        disposable?.dispose()
        self.creating.accept(true)
        self.disposable = self.modelManager.createOne(name: self.name.value!).subscribe(onNext: {[weak self] model in
            completionHandler(model.id)
            self?.creating.accept(false)
        })
    }
    
   
    
    deinit {
        self.disposable?.dispose()
    }
    
}
