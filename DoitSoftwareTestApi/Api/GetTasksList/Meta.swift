//
//  Meta.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 25.12.2020.
//

import Foundation

public struct Meta {
    public let current: Int
    public let limit: Int
    public let count: Int
    
    init(current: Int, limit: Int, count: Int) {
        self.current = current
        self.limit = limit
        self.count = count
    }
}
