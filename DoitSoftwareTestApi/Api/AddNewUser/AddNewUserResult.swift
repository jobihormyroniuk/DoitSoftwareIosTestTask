//
//  AddNewUserResult.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import Foundation

public enum AddNewUserResult {
    case addedNewUser(AddedNewUser)
    case validationFailed(String)
}
