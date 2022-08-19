//
//  UpdateTaskHttpExchange.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import AFoundation

class UpdateTaskHttpExchange: ApiHttpExchange<UpdatingTask, UpdateTaskResult> {
    override func constructRequest() throws -> HttpRequest {
        let method = HttpRequestMethod.put
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "\(basePath)/tasks/\(requestData.id)"
        let uri = try urlComponents.url()
        var headers: [String: String] = [:]
        headers[HttpHeaderField.contentType] = MediaType.json
        headers["Authorization"] = "Bearer \(requestData.token)"
        var jsonObject = JsonObject()
        if let title = requestData.title {
            jsonObject.setString(title, for: "title")
        }
        if let double = requestData.dueBy?.timeIntervalSince1970 {
            jsonObject.setNumber(Decimal(double), for: "dueBy")
        }
        if let priority = requestData.priority?.rawValue {
            jsonObject.setString(priority, for: "priority")
        }
        let body = try JsonSerialization.data(jsonObject)
        let httpRequest = HttpRequest(method: method, uri: uri, version: HttpVersion.http1dot1, headers: headers, body: body)
        return httpRequest
    }
    
    override func parseResponse(_ httpResponse: HttpResponse) throws -> UpdateTaskResult {
        let code = httpResponse.code
        if code == HttpResponseCode.accepted {
            return .updatedTask
        } else if code == HttpResponseCode.unauthorized {
            let body = httpResponse.body ?? Data()
            let jsonValue = try JsonSerialization.jsonValue(body)
            let jsonObject = try jsonValue.object()
            let message = try jsonObject.string("message")
            return .unauthorized(message)
        } else if code == 422 {
            let body = httpResponse.body ?? Data()
            let jsonValue = try JsonSerialization.jsonValue(body)
            let jsonObject = try jsonValue.object()
            let message = try jsonObject.string("message")
            return .validationFailed(message)
        } else {
            let error = MessageError("")
            throw error
        }
    }
}
