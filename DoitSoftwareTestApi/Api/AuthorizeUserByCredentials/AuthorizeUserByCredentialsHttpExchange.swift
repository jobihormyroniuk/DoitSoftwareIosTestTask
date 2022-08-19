//
//  AuthorizeUserByCredentialsHttpExchange.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 25.12.2020.
//

import AFoundation

class AuthorizeUserByCredentialsHttpExchange: ApiHttpExchange<AddingNewUser, AuthorizeUserByCredentialsResult> {
    override func constructRequest() throws -> HttpRequest {
        let method = HttpRequestMethod.post
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "\(basePath)/auth"
        let uri = try urlComponents.url()
        var headers: [String: String] = [:]
        headers[HttpHeaderField.contentType] = MediaType.json
        var jsonObject = JsonObject()
        jsonObject.setString(requestData.email, for: "email")
        jsonObject.setString(requestData.password, for: "password")
        let body = try JsonSerialization.data(jsonObject)
        let httpRequest = HttpRequest(method: method, uri: uri, version: HttpVersion.http1dot1, headers: headers, body: body)
        return httpRequest
    }
    
    override func parseResponse(_ httpResponse: HttpResponse) throws -> AuthorizeUserByCredentialsResult {
        let code = httpResponse.code
        if code == HttpResponseCode.ok {
            let body = httpResponse.body ?? Data()
            let jsonValue = try JsonSerialization.jsonValue(body)
            let jsonObject = try jsonValue.object()
            let token = try jsonObject.string("token")
            let addedNewUser = AddedNewUser(token: token)
            return .authorizeUserByCredentials(addedNewUser)
        } else if code == HttpResponseCode.forbidden {
            let body = httpResponse.body ?? Data()
            let jsonValue = try JsonSerialization.jsonValue(body)
            let jsonObject = try jsonValue.object()
            let message = try jsonObject.string("message")
            return .wrongCredentials(message)
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
