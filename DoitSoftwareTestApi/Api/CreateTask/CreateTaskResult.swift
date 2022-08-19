//
//  CreateTaskResult.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 25.12.2020.
//

import Foundation

public enum CreateTaskResult {
    case createdTaskResult(CreatedTask)
    case unauthorized(String)
    case validationFailed(String)
}
