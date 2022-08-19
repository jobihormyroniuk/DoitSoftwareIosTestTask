//
//  UrlSessionSharedInteractor.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 25.12.2020.
//

import ASwift
import AFoundation

class UrlSessionSharedInteractor: Interactor {
    
    private let session = URLSession.shared
    private let api: Api
    
    public init(scheme: String, host: String) {
        let api = Api(scheme: scheme, host: host)
        self.api = api
    }
    
    public func addNewUser(addingNewUser: AddingNewUser, completionHandler: @escaping (Result<AddNewUserResult, InteractionError>) -> ()) {
        let httpExchange = api.addNewUser(requestData: addingNewUser)
        do {
            let dataTask = try session.httpExchangeDataTask(httpExchange) { result in
                switch result {
                case let .success(result):
                    switch result {
                    case let .parsedResponse(parsedResponse):
                        completionHandler(.success(parsedResponse))
                    case .networkConnectionLost(_):
                        completionHandler(.failure(.notConnectedToInternet))
                    case .notConnectedToInternet(_):
                        completionHandler(.failure(.notConnectedToInternet))
                    }
                case let .failure(error):
                    completionHandler(.failure(.unexpectedError(error: error)))
                }
            }
            dataTask.resume()
        } catch {
            completionHandler(.failure(.unexpectedError(error: error)))
            return
        }
    }
    
    func authorizeUserByCredentials(authorizingUserByCredentials: AddingNewUser, completionHandler: @escaping (Result<AuthorizeUserByCredentialsResult, InteractionError>) -> ()) {
        let httpExchange = api.authorizeUserByCredentials(requestData: authorizingUserByCredentials)
        do {
            let dataTask = try session.httpExchangeDataTask(httpExchange) { result in
                switch result {
                case let .success(result):
                    switch result {
                    case let .parsedResponse(parsedResponse):
                        completionHandler(.success(parsedResponse))
                    case .networkConnectionLost(_):
                        completionHandler(.failure(.notConnectedToInternet))
                    case .notConnectedToInternet(_):
                        completionHandler(.failure(.notConnectedToInternet))
                    }
                case let .failure(error):
                    completionHandler(.failure(.unexpectedError(error: error)))
                }
            }
            dataTask.resume()
        } catch {
            completionHandler(.failure(.unexpectedError(error: error)))
            return
        }
    }
    
    func createTask(creatingTask: CreatingTask, completionHandler: @escaping (Result<CreateTaskResult, InteractionError>) -> ()) {
        let httpExchange = api.createTask(requestData: creatingTask)
        do {
            let dataTask = try session.httpExchangeDataTask(httpExchange) { result in
                switch result {
                case let .success(result):
                    switch result {
                    case let .parsedResponse(parsedResponse):
                        completionHandler(.success(parsedResponse))
                    case .networkConnectionLost(_):
                        completionHandler(.failure(.notConnectedToInternet))
                    case .notConnectedToInternet(_):
                        completionHandler(.failure(.notConnectedToInternet))
                    }
                case let .failure(error):
                    completionHandler(.failure(.unexpectedError(error: error)))
                }
            }
            dataTask.resume()
        } catch {
            completionHandler(.failure(.unexpectedError(error: error)))
            return
        }
    }
    
    func getTasksList(gettingTasksList: GettingTasksList, completionHandler: @escaping (Result<GetTasksListResult, InteractionError>) -> ()) {
        let httpExchange = api.getTasksList(requestData: gettingTasksList)
        do {
            let dataTask = try session.httpExchangeDataTask(httpExchange) { result in
                switch result {
                case let .success(result):
                    switch result {
                    case let .parsedResponse(parsedResponse):
                        completionHandler(.success(parsedResponse))
                    case .networkConnectionLost(_):
                        completionHandler(.failure(.notConnectedToInternet))
                    case .notConnectedToInternet(_):
                        completionHandler(.failure(.notConnectedToInternet))
                    }
                case let .failure(error):
                    completionHandler(.failure(.unexpectedError(error: error)))
                }
            }
            dataTask.resume()
        } catch {
            completionHandler(.failure(.unexpectedError(error: error)))
            return
        }
    }
    
    func getTaskDetails(gettingTaskDetails: GettingTaskDetails, completionHandler: @escaping (Result<GetTaskDetailsResult, InteractionError>) -> ()) {
        let httpExchange = api.getTaskDetails(requestData: gettingTaskDetails)
        do {
            let dataTask = try session.httpExchangeDataTask(httpExchange) { result in
                switch result {
                case let .success(result):
                    switch result {
                    case let .parsedResponse(parsedResponse):
                        completionHandler(.success(parsedResponse))
                    case .networkConnectionLost(_):
                        completionHandler(.failure(.notConnectedToInternet))
                    case .notConnectedToInternet(_):
                        completionHandler(.failure(.notConnectedToInternet))
                    }
                case let .failure(error):
                    completionHandler(.failure(.unexpectedError(error: error)))
                }
            }
            dataTask.resume()
        } catch {
            completionHandler(.failure(.unexpectedError(error: error)))
            return
        }
    }
    
    func updateTask(updatingTask: UpdatingTask, completionHandler: @escaping (Result<UpdateTaskResult, InteractionError>) -> ()) {
        let httpExchange = api.updateTask(requestData: updatingTask)
        do {
            let dataTask = try session.httpExchangeDataTask(httpExchange) { result in
                switch result {
                case let .success(result):
                    switch result {
                    case let .parsedResponse(parsedResponse):
                        completionHandler(.success(parsedResponse))
                    case .networkConnectionLost(_):
                        completionHandler(.failure(.notConnectedToInternet))
                    case .notConnectedToInternet(_):
                        completionHandler(.failure(.notConnectedToInternet))
                    }
                case let .failure(error):
                    completionHandler(.failure(.unexpectedError(error: error)))
                }
            }
            dataTask.resume()
        } catch {
            completionHandler(.failure(.unexpectedError(error: error)))
            return
        }
    }
    
    func deleteTask(deletingTask: GettingTaskDetails, completionHandler: @escaping (Result<DeleteTaskResult, InteractionError>) -> ()) {
        let httpExchange = api.deleteTask(requestData: deletingTask)
        do {
            let dataTask = try session.httpExchangeDataTask(httpExchange) { result in
                switch result {
                case let .success(result):
                    switch result {
                    case let .parsedResponse(parsedResponse):
                        completionHandler(.success(parsedResponse))
                    case .networkConnectionLost(_):
                        completionHandler(.failure(.notConnectedToInternet))
                    case .notConnectedToInternet(_):
                        completionHandler(.failure(.notConnectedToInternet))
                    }
                case let .failure(error):
                    completionHandler(.failure(.unexpectedError(error: error)))
                }
            }
            dataTask.resume()
        } catch {
            completionHandler(.failure(.unexpectedError(error: error)))
            return
        }
    }
    
}
