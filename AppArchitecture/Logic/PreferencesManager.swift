//
//  PreferenceManager.swift
//  example
//
//  Created by Alex on 4/7/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation


enum PreferencesKey: String, CaseIterable {
    case authToken
}


protocol PreferencesManager {
    subscript<T>(key: PreferencesKey)->T? { get set }
    func clean()
}



class DefaultPreferenceManager: PreferencesManager{
    
    private let storage:KeyValueStorage
    
    init(storage:KeyValueStorage) {
        self.storage = storage
    }
    
    subscript<T>(key: PreferencesKey) -> T? {
        get {
            return self.storage.value(for: key.rawValue)
        }
        set {
            self.storage.set(value: newValue, for: key.rawValue)
        }
    }
    
    func clean() {
        PreferencesKey.allCases.map({$0.rawValue}).forEach(self.storage.remove)
    }
    
}
