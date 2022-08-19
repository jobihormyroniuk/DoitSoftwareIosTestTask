//
//  UpdateTaskResult.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import Foundation

public enum UpdateTaskResult {
    case updatedTask
    case unauthorized(String)
    case validationFailed(String)
}
