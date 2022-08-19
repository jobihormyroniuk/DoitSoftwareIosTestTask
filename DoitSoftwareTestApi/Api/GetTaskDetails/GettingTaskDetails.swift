//
//  GettingTaskDetails.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import Foundation

public struct GettingTaskDetails {
    let token: String
    let task: Int
    
    public init(token: String, task: Int) {
        self.token = token
        self.task = task
    }
}
