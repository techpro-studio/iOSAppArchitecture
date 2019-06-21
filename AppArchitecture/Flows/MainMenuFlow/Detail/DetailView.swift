//
//  DetailView.swift
//  ios_app_architecture
//
//  Created by Alex on 6/21/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RCKit



protocol DetailView: ViewContainer {
    var label: UILabel { get }
}


class DefaultDetailView: View, DetailView {

    let label: UILabel = UILabel().layoutable()

    override func setup() {
        addSubview(label)
        backgroundColor = .white
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}
