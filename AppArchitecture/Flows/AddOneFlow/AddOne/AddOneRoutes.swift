//
//  AddOneView.swift
//  example
//
//  Created by Alex on 4/10/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import RCKit


protocol AddOneRoutes: ModuleRoutes {
    var canceled: (()->Void)! { get set }
    var finished: ((String)->Void)! { get set }
}
