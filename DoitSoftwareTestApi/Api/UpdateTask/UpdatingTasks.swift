//
//  UpdatingTasks.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import Foundation

public struct UpdatingTask {
    let token: String
    let id: Int
    let title: String?
    let dueBy: Date?
    let priority: TaskPriority?
    
    public init(token: String, id: Int, title: String?, dueBy: Date?, priority: TaskPriority?) {
        self.token = token
        self.id = id
        self.title = title
        self.dueBy = dueBy
        self.priority = priority
    }
}
