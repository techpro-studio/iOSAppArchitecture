//
//  UIView+Extensions.swift
//  example
//
//  Created by Alex on 4/10/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import UIKit
import RCKit

extension UIView {
    
    var ltr: Bool{
        return UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == .leftToRight
    }
    
    
    func fill(in view: UIView, insets: UIEdgeInsets = .zero){
        view.addSubview(self)
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.ltr ? insets.left : insets.right).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.ltr ? insets.right : insets.left).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).isActive  = true
    }
}

extension UIView {

    func layoutable() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

class View: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()

    }

    func setup(){
        abstractMethod()
    }
}
