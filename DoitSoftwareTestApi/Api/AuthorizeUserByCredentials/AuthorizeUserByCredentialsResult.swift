//
//  AuthorizeUserByCredentialsResult.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 25.12.2020.
//

import Foundation

public enum AuthorizeUserByCredentialsResult {
    case authorizeUserByCredentials(AddedNewUser)
    case wrongCredentials(String)
    case validationFailed(String)
}
