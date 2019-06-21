//
//  ModelCollectionViewCell.swift
//  example
//
//  Created by Alex on 4/8/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class ModelCollectionViewCell: UICollectionViewCell {

    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label.layoutable()
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

    }
}
