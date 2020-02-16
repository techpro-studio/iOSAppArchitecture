//
//  AddOneCoordinator.swift
//  example
//
//  Created by Alex on 4/10/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import UIKit
import Swinject
import RCKit


class AddOneCoordinator: BaseCoordinator, UIAdaptivePresentationControllerDelegate{
    
    private unowned var source: UIViewController
    
    var finished: ((String?)->Void)!

    private var navigationController: UINavigationController!

    init(source: UIViewController, container: Container){
        self.source = source
        super.init(container: buildAddOneContainer(parent: container))
    }
    
    override func performStop(completionHandler: @escaping () -> Void) {
        self.navigationController?.dismiss(animated: true, completion: completionHandler) ?? completionHandler()
    }
    
    override func start() {
        self.runMain()
    }

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.stop {[weak self] in
            self?.finished(nil)
        }
    }
    
    func runMain(){
        let view = self.container.resolve(AddOneFactory.self)!.make()
        
        view.canceled = {[weak self] in
            self?.stop {[weak self] in
                self?.finished(nil)
            }
        }
        
        view.finished = {[weak self] id in
            self?.stop {[weak self] in
                self?.finished(id)
            }
        }
        
        navigationController = UINavigationController(rootViewController: view.viewController)
        source.present(navigationController, animated: true, completion: nil)
        navigationController.presentationController?.delegate = self
    }
    
}
