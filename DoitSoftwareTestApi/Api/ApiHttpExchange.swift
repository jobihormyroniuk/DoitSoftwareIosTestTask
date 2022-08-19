//
//  WebApiHttpExchange.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 25.12.2020.
//

import AFoundation

class ApiHttpExchange<RequestData, ParsedResponse>: SchemeHostRequestDataHttpExchange<RequestData, ParsedResponse> {
    let basePath: String = "/api"
}
