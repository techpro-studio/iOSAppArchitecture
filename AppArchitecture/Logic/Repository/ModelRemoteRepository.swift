//
//  ModelRemoteRepository.swift
//  example
//
//  Created by Alex on 4/8/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RxSwift





protocol ModelRemoteRepository {
    func getNew()->Observable<[Model]>
    func getOne(id:String)->Observable<Model>
    func createOne(id:String, name:String)->Observable<Model>
}
