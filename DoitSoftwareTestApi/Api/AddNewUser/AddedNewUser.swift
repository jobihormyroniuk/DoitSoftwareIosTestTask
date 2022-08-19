//
//  AddedNewUser.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 25.12.2020.
//

import Foundation

public struct AddedNewUser {
    public let token: String
    
    init(token: String) {
        self.token = token
    }
}
