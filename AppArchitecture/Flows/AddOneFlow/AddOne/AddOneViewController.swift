//
//  AddOneViewController.swift
//  example
//
//  Created by Alex on 4/10/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit
import RCKit
import RxSwift

class AddOneViewController: UIViewController, AddOneRoutes, UIAdaptivePresentationControllerDelegate {

    var canceled: (() -> Void)!
    var finished: ((String) -> Void)!
    let presenter: AddOnePresenter
    let viewContainer: AddOneView

    init(presenter: AddOnePresenter, viewContainer: AddOneView) {
        self.presenter = presenter
        self.viewContainer = viewContainer
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("Add new one", comment: "")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancel))
        
        self.viewContainer.addButton.addTarget(self, action: #selector(self.add), for: .touchUpInside)
        
        (self.viewContainer.textField.rx.text <-> self.presenter.name).disposed(by:self.disposeBag)
        
        self.presenter.addButtonAvailable.asObservable().observeOn(MainScheduler.instance).bind(to: self.viewContainer.addButton.rx.isEnabled).disposed(by: self.disposeBag)
        
        self.viewContainer.textField.becomeFirstResponder()

        self.viewContainer.view.layoutable().fill(in: self.view)
    }
    
    @objc func cancel(){
        self.canceled()
    }
    
    @objc func add(){
        self.presenter.create(completionHandler: {[weak self] id in
            self?.finished(id)
        })
    }

}
