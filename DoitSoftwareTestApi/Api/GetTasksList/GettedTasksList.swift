//
//  GettedTasksList.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 25.12.2020.
//

import Foundation

public struct GettedTasksList {
    public let tasks: [CreatedTask]
    public let meta: Meta
    
    init(tasks: [CreatedTask], meta: Meta) {
        self.tasks = tasks
        self.meta = meta
    }
}
