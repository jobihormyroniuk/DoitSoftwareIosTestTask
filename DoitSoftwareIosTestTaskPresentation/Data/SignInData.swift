//
//  SignInData.swift
//  DoitSoftwareIosTestTaskPresentation
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import Foundation

public struct SignInData {
    public let email: String
    public let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
