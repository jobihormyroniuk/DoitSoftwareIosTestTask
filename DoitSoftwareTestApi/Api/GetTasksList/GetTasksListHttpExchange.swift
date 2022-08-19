//
//  TasksListHttpExchange.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 25.12.2020.
//

import ASwift
import AFoundation

class GetTasksListHttpExchange: ApiHttpExchange<GettingTasksList, GetTasksListResult> {
    override func constructRequest() throws -> HttpRequest {
        let method = HttpRequestMethod.get
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "\(basePath)/tasks"
        let pageUrlQueryItem = URLQueryItem(name: "page", value: "\(requestData.page)")
        let urlQeryItems: [URLQueryItem] = [pageUrlQueryItem]
        urlComponents.queryItems = urlQeryItems
        let uri = try urlComponents.url()
        var headers: [String: String] = [:]
        headers[HttpHeaderField.contentType] = MediaType.json
        headers["Authorization"] = "Bearer \(requestData.token)"
        let httpRequest = HttpRequest(method: method, uri: uri, version: HttpVersion.http1dot1, headers: headers, body: nil)
        return httpRequest
    }
    
    override func parseResponse(_ httpResponse: HttpResponse) throws -> GetTasksListResult {
        let code = httpResponse.code
        if code == HttpResponseCode.ok {
            let body = httpResponse.body ?? Data()
            let jsonValue = try JsonSerialization.jsonValue(body)
            let jsonObject = try jsonValue.object()
            let tasksJsonArray = try jsonObject.array("tasks").objects()
            var tasks: [CreatedTask] = []
            for taskJsonObject in tasksJsonArray {
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
                let task = CreatedTask(id: id, title: title, dueBy: dueBy, priority: priority)
                tasks.append(task)
            }
            let metaJsonObject = try jsonObject.object("meta")
            let current = try metaJsonObject.number("current").int()
            let limit = try metaJsonObject.number("limit").int()
            let count = try metaJsonObject.number("count").int()
            let meta = Meta(current: current, limit: limit, count: count)
            let gettedTasksList = GettedTasksList(tasks: tasks, meta: meta)
            return .gettedTasksList(gettedTasksList)
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

