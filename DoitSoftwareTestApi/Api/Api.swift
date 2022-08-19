//
//  Api.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 25.12.2020.
//

import Foundation

class Api {
    
    private let scheme: String
    private let host: String
    
    init(scheme: String, host: String) {
        self.scheme = scheme
        self.host = host
    }
    
    func addNewUser(requestData: AddingNewUser) -> AddNewUserHttpExchange {
        let httpExchange = AddNewUserHttpExchange(scheme: scheme, host: host, requestData: requestData)
        return httpExchange
    }
    
    func authorizeUserByCredentials(requestData: AddingNewUser) -> AuthorizeUserByCredentialsHttpExchange {
        let httpExchange = AuthorizeUserByCredentialsHttpExchange(scheme: scheme, host: host, requestData: requestData)
        return httpExchange
    }
    
    func createTask(requestData: CreatingTask) -> CreateTaskHttpExchange {
        let httpExchange = CreateTaskHttpExchange(scheme: scheme, host: host, requestData: requestData)
        return httpExchange
    }
    
    func getTasksList(requestData: GettingTasksList) -> GetTasksListHttpExchange {
        let httpExchange = GetTasksListHttpExchange(scheme: scheme, host: host, requestData: requestData)
        return httpExchange
    }
    
    func getTaskDetails(requestData: GettingTaskDetails) -> GetTaskDetailsHttpExchange {
        let httpExchange = GetTaskDetailsHttpExchange(scheme: scheme, host: host, requestData: requestData)
        return httpExchange
    }
    
    func deleteTask(requestData: GettingTaskDetails) -> DeleteTaskHttpExchange {
        let httpExchange = DeleteTaskHttpExchange(scheme: scheme, host: host, requestData: requestData)
        return httpExchange
    }
    
    func updateTask(requestData: UpdatingTask) -> UpdateTaskHttpExchange {
        let httpExchange = UpdateTaskHttpExchange(scheme: scheme, host: host, requestData: requestData)
        return httpExchange
    }
    
}
