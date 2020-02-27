//
//  ListViewPresenter.swift
//  example
//
//  Created by Alex on 4/8/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RCKit
import RxSwift
import RxCocoa
import RCRealm

protocol ListViewPresenter: ErrorThrowablePresenter, LoadablePresenter, DisposableContainer {
    var total: Int { get }
    func item(at index: Int) -> Model
    func refresh()
    var refreshAvailable: BehaviorRelay<Bool> { get }
    var changeSetObservable: Observable<ChangeSet> { get }
}



class DefaultListViewPresenter:  ListViewPresenter {

    var isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    var error: PublishSubject<Error> = PublishSubject()
    
    var alert: PublishSubject<(message: String, title: String)> = PublishSubject()
    
    var disposable: Disposable?=nil
    
    let refreshAvailable: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    lazy var changeSetObservable: Observable<ChangeSet> = self.container.subscribeForChanges()
    
    var total: Int{
        return container.count
    }
    
    private let container: LazyContainer<Model>
    private let reachabilityManager: ReachabilityManager
    private let modelManager: ModelManager
    
    internal let disposeBag = DisposeBag()
    
    init(reachabilityManager: ReachabilityManager, modelManager: ModelManager){
        self.reachabilityManager = reachabilityManager
        self.modelManager = modelManager
        self.container = modelManager.getAll()
        self.computeObservables()
    }
    
    func computeObservables(){
        self.reachabilityManager.connectionIsReachable.asObservable().bind(to: self.refreshAvailable).disposed(by: self.disposeBag)
    }
    
    func item(at index: Int) -> Model {
        return container[index]
    }
    
    func refresh() {
        self.runObservable(observable: self.modelManager.sync())
    }
    
    deinit {
        disposable?.dispose()
    }
    
}
