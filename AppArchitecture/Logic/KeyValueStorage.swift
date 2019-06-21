//
//  KeyValueStorage.swift
//  example
//
//  Created by Alex on 4/7/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation


protocol KeyValueStorage{
    
    func set<T>(value:T?, for key: String)
    func value<T>(for key:String)->T?
    func remove(for key: String)
}




extension UserDefaults: KeyValueStorage{
    
    func set<T>(value: T?, for key: String) {
        self.set(value, forKey: key)
        self.synchronize()
    }
    
    func value<T>(for key: String) -> T? {
        return self.object(forKey: key) as? T
    }
    
    func remove(for key: String) {
        self.removeObject(forKey:key)
        self.synchronize()
    }
    
}
