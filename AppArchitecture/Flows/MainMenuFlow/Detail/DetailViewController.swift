//
//  DetailViewController.swift
//  example
//
//  Created by Alex on 4/9/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class DetailViewController: UIViewController, DetailRoutes {
    
    let presenter: DetailPresenter
    let viewContainer: DetailView

    init(presenter: DetailPresenter, view: DetailView) {
        self.presenter = presenter
        self.viewContainer = view
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let disposeBag = DisposeBag()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewContainer.view.layoutable().fill(in: self.view)
        
        self.presenter.model.asObservable().map({$0?.name ?? ""}).observeOn(MainScheduler.instance).bind(to: self.rx.title).disposed(by: self.disposeBag)
        
        self.presenter.model.asObservable().map({$0?.id }).observeOn(MainScheduler.instance).bind(to: self.viewContainer.label.rx.text).disposed(by: self.disposeBag)
        
    }

}
