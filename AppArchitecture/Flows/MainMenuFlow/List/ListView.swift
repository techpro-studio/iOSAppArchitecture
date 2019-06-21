//
//  ListView.swift
//  ios_app_architecture
//
//  Created by Alex on 6/21/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RCKit


protocol ListView: ViewContainer {
    var collectionView: UICollectionView { get }
    var refreshControl: UIRefreshControl { get }
    func setRefreshAvailable(value: Bool)
}


class DefaultListView: View, ListView {

    let refreshControl: UIRefreshControl = UIRefreshControl()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5.0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ModelCollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true

        collectionView.backgroundColor = .white
        return collectionView.layoutable()
    }()

    func setRefreshAvailable(value: Bool) {
        value ? self.collectionView.addSubview(self.refreshControl) : self.refreshControl.removeFromSuperview()
    }

    override func setup() {
        collectionView.fill(in: self)
    }

}
