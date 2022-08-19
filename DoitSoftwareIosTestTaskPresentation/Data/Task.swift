//
//  Task.swift
//  DoitSoftwareIosTestTaskPresentation
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import Foundation

public struct Task {
    public let id: Int
    public let title: String
    public let dueBy: Date
    public let priority: TaskPriority
    
    public init(id: Int, title: String, dueBy: Date, priority: TaskPriority) {
        self.id = id
        self.title = title
        self.dueBy = dueBy
        self.priority = priority
    }
}

public enum TaskPriority: String {
    case high = "High"
    case medium = "Medium"
    case low = "Low"
}

public struct CreatingTask {
    public let title: String
    public let dueBy: Date
    public let priority: TaskPriority
    
    public init(title: String, dueBy: Date, priority: TaskPriority) {
        self.title = title
        self.dueBy = dueBy
        self.priority = priority
    }
}
