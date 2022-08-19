//
//  GettingTasksList.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import Foundation

public struct GettingTasksList {
    let token: String
    let page: Int
    
    public init(token: String, page: Int) {
        self.token = token
        self.page = page
    }
}
