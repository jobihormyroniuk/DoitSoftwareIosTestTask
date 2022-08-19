//
//  GetTasksListResult.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import Foundation

public enum GetTasksListResult {
    case gettedTasksList(GettedTasksList)
    case unauthorized(String)
}
