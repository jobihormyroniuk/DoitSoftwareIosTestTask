//
//  CreatedTask.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 25.12.2020.
//

import Foundation

public struct CreatedTask {
    public let id: Int
    public let title: String
    public let dueBy: Date
    public let priority: TaskPriority
    
    init(id: Int, title: String, dueBy: Date, priority: TaskPriority) {
        self.id = id
        self.title = title
        self.dueBy = dueBy
        self.priority = priority
    }
}
