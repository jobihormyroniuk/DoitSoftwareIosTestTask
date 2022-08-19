//
//  InteractionError.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 25.12.2020.
//

import Foundation

public enum InteractionError: Error {
    case notConnectedToInternet
    case unexpectedError(error: Error)
    
    init(error: Error) {
        if (error as NSError).code == NSURLErrorNotConnectedToInternet {
            self = .notConnectedToInternet
        } else {
            self = .unexpectedError(error: error)
        }
    }
    
}
