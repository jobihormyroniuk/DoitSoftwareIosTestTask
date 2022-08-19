//
//  DeleteTaskHttpExchange.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import AFoundation

class DeleteTaskHttpExchange: ApiHttpExchange<GettingTaskDetails, DeleteTaskResult> {
    
    override func constructRequest() throws -> HttpRequest {
        let method = HttpRequestMethod.delete
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "\(basePath)/tasks/\(requestData.task)"
        let uri = try urlComponents.url()
        var headers: [String: String] = [:]
        headers[HttpHeaderField.contentType] = MediaType.json
        headers["Authorization"] = "Bearer \(requestData.token)"
        let httpRequest = HttpRequest(method: method, uri: uri, version: HttpVersion.http1dot1, headers: headers, body: nil)
        return httpRequest
    }
    
    override func parseResponse(_ httpResponse: HttpResponse) throws -> DeleteTaskResult {
        let code = httpResponse.code
        if code == HttpResponseCode.accepted {
            return .deletedTask
        } else if code == HttpResponseCode.unauthorized {
            let body = httpResponse.body ?? Data()
            let jsonValue = try JsonSerialization.jsonValue(body)
            let jsonObject = try jsonValue.object()
            let message = try jsonObject.string("message")
            return .unauthorized(message)
        } else {
            let error = MessageError("")
            throw error
        }
    }
    
}
