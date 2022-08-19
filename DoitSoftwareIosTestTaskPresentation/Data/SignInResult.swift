//
//  SignInResult.swift
//  DoitSoftwareIosTestTaskPresentation
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import Foundation

public enum SignInResult {
    case success
    case wrongCredentials(String)
    case validationFailed(String)
}
