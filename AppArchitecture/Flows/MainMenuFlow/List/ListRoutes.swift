//
//  ListView.swift
//  example
//
//  Created by Alex on 4/8/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RCKit


protocol ListRoutes: ModuleRoutes {
    var showDetail: ((String)->Void)! { get set }
    var addNewOne: (()->Void)! { get set }
}
