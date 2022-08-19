//
//  GetTaskDetailsResult.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import Foundation

public enum GetTaskDetailsResult {
    case gettedTaskDetails(CreatedTask)
    case unauthorized(String)
}
