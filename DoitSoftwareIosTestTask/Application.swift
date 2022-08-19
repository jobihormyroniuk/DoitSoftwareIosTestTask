//
//  Application.swift
//  DoitSoftwareIosTestTask
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import AUIKit
import DoitSoftwareTestApi
import DoitSoftwareIosTestTaskPresentation
import DoitSoftwareIosTestTaskStorage
import DoitSoftwareIosTestTaskNotifier

class Application: AUIEmptyApplication, IphonePresentationDelegate {
    
    // MARK: Launching
    
    override func didFinishLaunching() {
        super.didFinishLaunching()
        launchPresentation()
    }
    
    // MARK: DOIT Software Test Api
    
    private lazy var apiInteractor: Interactor = {
        let interactor = Interactors.interactor
        return interactor
    }()
    
    // MARK: Storage
    
    private lazy var storage: Storage = {
        let storage = Storage()
        return storage
    }()
    
    private lazy var notifier: Notifier = {
        let notifier = Notifier()
        return notifier
    }()
    
    // MARK: Presentation
    
    private lazy var presentationWindow: UIWindow = {
        return window ?? UIWindow()
    }()
    
    private lazy var iphonePresentation: IphonePresentation = {
        let iphonePresentation = IphonePresentation(window: presentationWindow)
        iphonePresentation.delegate = self
        return iphonePresentation
    }()
    
    private func launchPresentation() {
        if storage.token == nil {
            iphonePresentation.requireSignInSignUp()
        } else {
            iphonePresentation.beReadySignedIn()
        }
        presentationWindow.makeKeyAndVisible()
        notifier.registerLocal()
        let task = Task2(id: 1, title: "bla", dueBy: Date(), priority: .high)
        notifier.scheduleTask(task)
    }
    
    // MARK: IphonePresentationDelegate
    
    func iphonePresentationSignUp(_ iphonePresentation: IphonePresentation, data: SignInData, completionHandler: @escaping (Result<SignUpResult, Error>) -> ()) {
        let addingNewUser = AddingNewUser(email: data.email, password: data.password)
        apiInteractor.addNewUser(addingNewUser: addingNewUser) { (result) in
            switch result {
            case .success(let addedNewUserResult):
                switch addedNewUserResult {
                case .addedNewUser(let addedNewUser):
                    self.storage.token = addedNewUser.token
                    completionHandler(.success(.success))
                case .validationFailed(let message):
                    completionHandler(.success(.validationFailed(message)))
                }
            case .failure(let interationError):
                completionHandler(.failure(interationError))
            }
        }
    }
    
    func iphonePresentationSignIn(_ iphonePresentation: IphonePresentation, data: SignInData, completionHandler: @escaping (Result<SignInResult, Error>) -> ()) {
        let authorizingUserByCredentials = AddingNewUser(email: data.email, password: data.password)
        apiInteractor.authorizeUserByCredentials(authorizingUserByCredentials: authorizingUserByCredentials) { (result) in
            switch result {
            case .success(let authorizeUserByCredentialsResult):
                switch authorizeUserByCredentialsResult {
                case .authorizeUserByCredentials(let authorizedUserByCredentials):
                    self.storage.token = authorizedUserByCredentials.token
                    completionHandler(.success(.success))
                case .validationFailed(let message):
                    completionHandler(.success(.validationFailed(message)))
                case .wrongCredentials(let message):
                    completionHandler(.success(.wrongCredentials(message)))
                }
            case .failure(let interationError):
                completionHandler(.failure(interationError))
            }
        }
    }
    
    func iphonePresentationTasksList(_ iphonePresentation: IphonePresentation, page: Int, completionHandler: @escaping (Result<[Task], Error>) -> ()) {
        guard let token = storage.token else {
            iphonePresentation.requireSignInSignUpAsync()
            return
        }
        let gettingTasksList = GettingTasksList(token: token, page: page)
        apiInteractor.getTasksList(gettingTasksList: gettingTasksList) { (result) in
            switch result {
            case .success(let authorizeUserByCredentialsResult):
                switch authorizeUserByCredentialsResult {
                case .gettedTasksList(let gettedTasksList):
                    var presentationTasks: [Task] = []
                    for apiTask in gettedTasksList.tasks {
                        let priority: DoitSoftwareIosTestTaskPresentation.TaskPriority
                        switch apiTask.priority {
                        case .high: priority = .high
                        case .medium: priority = .medium
                        case .low: priority = .low
                        }
                        let task = Task(id: apiTask.id, title: apiTask.title, dueBy: apiTask.dueBy, priority: priority)
                        presentationTasks.append(task)
                    }
                    completionHandler(.success(presentationTasks))
                case .unauthorized:
                    self.storage.token = nil
                    self.iphonePresentation.requireSignInSignUpAsync()
                }
            case .failure(let interationError):
                completionHandler(.failure(interationError))
            }
        }
    }
    
    func iphonePresentationTaskDetails(_ iphonePresentation: IphonePresentation, taskInList: Task, completionHandler: @escaping (Result<Task, Error>) -> ()) {
        guard let token = storage.token else {
            iphonePresentation.requireSignInSignUpAsync()
            return
        }
        let gettingTaskDetails = GettingTaskDetails(token: token, task: taskInList.id)
        apiInteractor.getTaskDetails(gettingTaskDetails: gettingTaskDetails) { (result) in
            switch result {
            case .success(let authorizeUserByCredentialsResult):
                switch authorizeUserByCredentialsResult {
                case .gettedTaskDetails(let gettedTaskDetails):
                    let priority: DoitSoftwareIosTestTaskPresentation.TaskPriority
                    switch gettedTaskDetails.priority {
                    case .high: priority = .high
                    case .medium: priority = .medium
                    case .low: priority = .low
                    }
                    let presentationTask = Task(id: gettedTaskDetails.id, title: gettedTaskDetails.title, dueBy: gettedTaskDetails.dueBy, priority: priority)
                    completionHandler(.success(presentationTask))
                case .unauthorized:
                    self.storage.token = nil
                    self.iphonePresentation.requireSignInSignUpAsync()
                }
            case .failure(let interationError):
                completionHandler(.failure(interationError))
            }
        }
    }
    
    func iphonePresentationTaskDelete(_ iphonePresentation: IphonePresentation, taskDetails: Task, completionHandler: @escaping (Error?) -> ()) {
        guard let token = storage.token else {
            iphonePresentation.requireSignInSignUpAsync()
            return
        }
        let deletingTask = GettingTaskDetails(token: token, task: taskDetails.id)
        apiInteractor.deleteTask(deletingTask: deletingTask) { (result) in
            switch result {
            case .success(let deteteTaskResult):
                switch deteteTaskResult {
                case .deletedTask:
                    completionHandler(nil)
                case .unauthorized:
                    self.storage.token = nil
                    self.iphonePresentation.requireSignInSignUpAsync()
                }
            case .failure(let interationError):
                completionHandler(interationError)
            }
        }
    }
    
    func iphonePresentationTaskCreate(_ iphonePresentation: IphonePresentation, creatingTask: DoitSoftwareIosTestTaskPresentation.CreatingTask, completionHandler: @escaping (Result<DoitSoftwareIosTestTaskPresentation.CreateTaskResult, Error>) -> ()) {
        guard let token = storage.token else {
            iphonePresentation.requireSignInSignUpAsync()
            return
        }
        let apiPriority: DoitSoftwareTestApi.TaskPriority
        switch creatingTask.priority {
        case .high: apiPriority = .high
        case .medium: apiPriority = .medium
        case .low: apiPriority = .low
        }
        let creatingTask = DoitSoftwareTestApi.CreatingTask(token: token, title: creatingTask.title, dueBy: creatingTask.dueBy, priority: apiPriority)
        apiInteractor.createTask(creatingTask: creatingTask) { (result) in
            switch result {
            case .success(let createTaskResult):
                switch createTaskResult {
                case .createdTaskResult:
                    completionHandler(.success(.success))
                case .validationFailed(let message):
                    completionHandler(.success(.validationFailed(message)))
                case .unauthorized(_):
                    self.storage.token = nil
                    self.iphonePresentation.requireSignInSignUpAsync()
                }
            case .failure(let interationError):
                completionHandler(.failure(interationError))
            }
        }
    }
    
    func iphonePresentationTaskEdit(_ iphonePresentation: IphonePresentation, editingTask: Task, completionHandler: @escaping (Result<DoitSoftwareIosTestTaskPresentation.CreateTaskResult, Error>) -> ()) {
        guard let token = storage.token else {
            iphonePresentation.requireSignInSignUpAsync()
            return
        }
        let apiPriority: DoitSoftwareTestApi.TaskPriority
        switch editingTask.priority {
        case .high: apiPriority = .high
        case .medium: apiPriority = .medium
        case .low: apiPriority = .low
        }
        let updatingTask = DoitSoftwareTestApi.UpdatingTask(token: token, id: editingTask.id, title: editingTask.title, dueBy: editingTask.dueBy, priority: apiPriority)
        apiInteractor.updateTask(updatingTask: updatingTask) { (result) in
            switch result {
            case .success(let updateTaskResult):
                switch updateTaskResult {
                case .updatedTask:
                    completionHandler(.success(.success))
                case .validationFailed(let message):
                    completionHandler(.success(.validationFailed(message)))
                case .unauthorized(_):
                    self.storage.token = nil
                    self.iphonePresentation.requireSignInSignUpAsync()
                }
            case .failure(let interationError):
                completionHandler(.failure(interationError))
            }
        }
    }
    
}
