//
//  Interactor.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 25.12.2020.
//

import AFoundation

public protocol Interactor {
    
    func addNewUser(addingNewUser: AddingNewUser, completionHandler: @escaping (Result<AddNewUserResult, InteractionError>) -> ())
    func authorizeUserByCredentials(authorizingUserByCredentials: AddingNewUser, completionHandler: @escaping (Result<AuthorizeUserByCredentialsResult, InteractionError>) -> ())
    func createTask(creatingTask: CreatingTask, completionHandler: @escaping (Result<CreateTaskResult, InteractionError>) -> ())
    func getTasksList(gettingTasksList: GettingTasksList, completionHandler: @escaping (Result<GetTasksListResult, InteractionError>) -> ())
    func getTaskDetails(gettingTaskDetails: GettingTaskDetails, completionHandler: @escaping (Result<GetTaskDetailsResult, InteractionError>) -> ())
    func updateTask(updatingTask: UpdatingTask, completionHandler: @escaping (Result<UpdateTaskResult, InteractionError>) -> ())
    func deleteTask(deletingTask: GettingTaskDetails, completionHandler: @escaping (Result<DeleteTaskResult, InteractionError>) -> ())
    
}
