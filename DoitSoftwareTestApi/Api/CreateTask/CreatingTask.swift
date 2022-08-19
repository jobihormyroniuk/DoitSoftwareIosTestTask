//
//  CreatingTask.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 25.12.2020.
//

import Foundation

public struct CreatingTask {
    let token: String
    let title: String
    let dueBy: Date
    let priority: TaskPriority
    
    public init(token: String, title: String, dueBy: Date, priority: TaskPriority) {
        self.token = token
        self.title = title
        self.dueBy = dueBy
        self.priority = priority
    }
}
