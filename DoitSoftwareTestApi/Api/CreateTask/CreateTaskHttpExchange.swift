//
//  CreateTaskHttpExchange.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 25.12.2020.
//

import ASwift
import AFoundation

class CreateTaskHttpExchange: ApiHttpExchange<CreatingTask, CreateTaskResult> {
    override func constructRequest() throws -> HttpRequest {
        let method = HttpRequestMethod.post
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "\(basePath)/tasks"
        let uri = try urlComponents.url()
        var headers: [String: String] = [:]
        headers[HttpHeaderField.contentType] = MediaType.json
        headers["Authorization"] = "Bearer \(requestData.token)"
        var jsonObject = JsonObject()
        jsonObject.setString(requestData.title, for: "title")
        jsonObject.setNumber(Decimal(requestData.dueBy.timeIntervalSince1970), for: "dueBy")
        jsonObject.setString(requestData.priority.rawValue, for: "priority")
        let body = try JsonSerialization.data(jsonObject)
        let httpRequest = HttpRequest(method: method, uri: uri, version: HttpVersion.http1dot1, headers: headers, body: body)
        return httpRequest
    }
    
    override func parseResponse(_ httpResponse: HttpResponse) throws -> CreateTaskResult {
        let code = httpResponse.code
        if code == HttpResponseCode.created {
            let body = httpResponse.body ?? Data()
            let jsonValue = try JsonSerialization.jsonValue(body)
            let jsonObject = try jsonValue.object()
            let taskJsonObject = try jsonObject.object("task")
            let id = try taskJsonObject.number("id").int()
            let title = try taskJsonObject.string("title")
            let dueByInt = try taskJsonObject.number("dueBy").double()
            let dueBy = Date(timeIntervalSince1970: dueByInt)
            let priorityRawValue = try taskJsonObject.string("priority")
            let optionalPriority = TaskPriority(rawValue: priorityRawValue)
            guard let priority = optionalPriority else {
                let error = UnexpectedError()
                throw error
            }
            let createdTask = CreatedTask(id: id, title: title, dueBy: dueBy, priority: priority)
            return .createdTaskResult(createdTask)
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
