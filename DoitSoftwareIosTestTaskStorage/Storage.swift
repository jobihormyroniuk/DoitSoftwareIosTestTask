//
//  Storage.swift
//  DoitSoftwareIosTestTaskStorage
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import Foundation

public class Storage {
    public var token: String? {
        // TODO: Need to use keychain in future
        get {
            let token = UserDefaults.standard.string(forKey: "token")
            return token
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "token")
        }
    }
    
    public init() {
        
    }
}
