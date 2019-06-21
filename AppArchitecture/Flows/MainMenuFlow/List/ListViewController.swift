//
//  ListViewController.swift
//  example
//
//  Created by Alex on 4/8/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ListViewController: UIViewController, ListRoutes, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var showDetail: ((String) -> Void)!
    var addNewOne: (() -> Void)!

    private let presenter: ListViewPresenter
    private let viewContainer: ListView

    init(presenter: ListViewPresenter, view: ListView) {
        self.presenter  = presenter
        self.viewContainer = view
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = NSLocalizedString("Model list", comment: "")

        self.viewContainer.refreshControl.addTarget(self, action: #selector(self.refreshList), for: .valueChanged)

        self.viewContainer.collectionView.dataSource = self
        self.viewContainer.collectionView.delegate = self

        self.viewContainer.view.layoutable().fill(in: self.view)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addOneModel))

        self.observePresenter()
    }
    
    @objc func refreshList(){
        self.presenter.refresh()
    }
    
    @objc private func addOneModel(){
        self.addNewOne()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50.0)
    }
    
    func observePresenter(){
    self.presenter.changeSetObservable.asObservable().observeOn(MainScheduler.instance).subscribe(onNext: {[weak self] _ in
            self?.viewContainer.collectionView.reloadData()
        }).disposed(by: self.disposeBag)
    self.presenter.refreshAvailable.asObservable().observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] available in
            guard let self = self else { return }
            self.viewContainer.setRefreshAvailable(value: available)
        }).disposed(by: self.disposeBag)
        
        self.presenter.isLoading.asObservable().subscribe(onNext: { [weak self] loading in
            loading ? self?.viewContainer.refreshControl.beginRefreshing() : self?.viewContainer.refreshControl.endRefreshing()
        }).disposed(by: self.disposeBag)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let item = self.presenter.item(at: indexPath.row)
        self.showDetail(item.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.total
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ModelCollectionViewCell
        let item = self.presenter.item(at: indexPath.row)
        cell.label.text = item.name
        return cell
    }
}
