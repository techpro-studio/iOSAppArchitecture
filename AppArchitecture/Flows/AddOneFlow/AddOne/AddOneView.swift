//
//  AddOneView.swift
//  example
//
//  Created by Alex on 6/21/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RCKit


protocol AddOneView: ViewContainer {
    var addButton: UIButton { get }
    var textField: UITextField { get }
}

class DefaultAddOneView: View, AddOneView {
    var addButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Add", comment: ""), for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button.layoutable()
    }()

    let textField: UITextField = {
        let field = UITextField()
        field.placeholder = NSLocalizedString("Name", comment: "")
        return field.layoutable()
    }()

    override func setup() {
        backgroundColor = .white

        [addButton, textField].forEach(addSubview)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 100.0),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16.0),
            textField.heightAnchor.constraint(equalToConstant: 50.0),
            addButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20.0)
        ])


    }

}
