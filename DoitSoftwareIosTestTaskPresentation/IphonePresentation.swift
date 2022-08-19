//
//  IPhonePresentation.swift
//  DoitSoftwareIosTestTaskPresentation
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import AUIKit

public protocol IphonePresentationDelegate: AnyObject {
    func iphonePresentationSignUp(_ iphonePresentation: IphonePresentation, data: SignInData, completionHandler: @escaping (Result<SignUpResult, Error>) -> ())
    func iphonePresentationSignIn(_ iphonePresentation: IphonePresentation, data: SignInData, completionHandler: @escaping (Result<SignInResult, Error>) -> ())
    func iphonePresentationTasksList(_ iphonePresentation: IphonePresentation, page: Int, completionHandler: @escaping (Result<[Task], Error>) -> ())
    func iphonePresentationTaskDetails(_ iphonePresentation: IphonePresentation, taskInList: Task, completionHandler: @escaping (Result<Task, Error>) -> ())
    func iphonePresentationTaskDelete(_ iphonePresentation: IphonePresentation, taskDetails: Task, completionHandler: @escaping (Error?) -> ())
    func iphonePresentationTaskCreate(_ iphonePresentation: IphonePresentation, creatingTask: CreatingTask, completionHandler: @escaping (Result<CreateTaskResult, Error>) -> ())
    func iphonePresentationTaskEdit(_ iphonePresentation: IphonePresentation, editingTask: Task, completionHandler: @escaping (Result<CreateTaskResult, Error>) -> ())
}

public class IphonePresentation: AUIWindowPresentation, SignInSignUpScreenControllerDelegate, TasksListScreenControllerDelegate, TaskDetailsScreenControllerDelegate, CreateTaskScreenControllerDelegate, EditTaskScreenControllerDelegate {
    public weak var delegate: IphonePresentationDelegate?
    
    public func requireSignInSignUp() {
        let signInSignUpScreenController = SignInSignUpScreenController()
        signInSignUpScreenController.delegate = self
        let mainNavigationController = AUINavigationController()
        mainNavigationController.viewControllers = [signInSignUpScreenController]
        self.mainNavigationController = mainNavigationController
        self.signInSignUpScreenController = signInSignUpScreenController
        window.rootViewController = mainNavigationController
    }
    
    public func requireSignInSignUpAsync() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.requireSignInSignUp()
        }
    }
    
    public func beReadySignedIn() {
        let tasksListScreenController = TasksListScreenController()
        tasksListScreenController.delegate = self
        let mainNavigationController = AUINavigationController()
        mainNavigationController.viewControllers = [tasksListScreenController]
        self.mainNavigationController = mainNavigationController
        self.tasksListScreenController = tasksListScreenController
        window.rootViewController = mainNavigationController
    }
    
    private func createAlertController(message: String) -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "Ok", style: .destructive)
        alertController.addAction(okAlertAction)
        return alertController
    }
    
    private func createErrorAlert(_ error: Error) -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: "Unexpected Error", preferredStyle: .alert)
        let shareAlertAction = UIAlertAction(title: "Share", style: .default) { alertAction in
            let ac = UIActivityViewController(activityItems: [String(reflecting: error)], applicationActivities: nil)
            self.mainNavigationController?.present(ac, animated: true)
        }
        alertController.addAction(shareAlertAction)
        let okAlertAction = UIAlertAction(title: "Ok", style: .destructive)
        alertController.addAction(okAlertAction)
        return alertController
    }
    
    // MARK: MainNavigationController
    
    weak var mainNavigationController: AUINavigationController?
    
    // MARK: SignInSignUpScreen
    
    weak var signInSignUpScreenController: SignInSignUpScreenController?
    
    func signInSignUpScreenControllerSignIn(_ signInSignUpScreenController: SignInSignUpScreenController, data: SignInData) {
        delegate?.iphonePresentationSignIn(self, data: data, completionHandler: { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let signInResult):
                    switch signInResult {
                    case .success:
                        let tasksListScreenController = TasksListScreenController()
                        tasksListScreenController.delegate = self
                        self.tasksListScreenController = tasksListScreenController
                        self.mainNavigationController?.viewControllers = [tasksListScreenController]
                    case .validationFailed(let message):
                        let alertController = self.createAlertController(message: message)
                        self.mainNavigationController?.present(alertController, animated: true, completion: nil)
                    case .wrongCredentials(let message):
                        let alertController = self.createAlertController(message: message)
                        self.mainNavigationController?.present(alertController, animated: true, completion: nil)
                    }
                case .failure(let error):
                    let alertController = self.createErrorAlert(error)
                    self.mainNavigationController?.present(alertController, animated: true, completion: nil)
                }
            }
        })
    }
    
    func signInSignUpScreenControllerSignUp(_ signInSignUpScreenController: SignInSignUpScreenController, data: SignInData) {
        delegate?.iphonePresentationSignUp(self, data: data, completionHandler: { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let signUpResult):
                    switch signUpResult {
                    case .success:
                        let tasksListScreenController = TasksListScreenController()
                        tasksListScreenController.delegate = self
                        self.tasksListScreenController = tasksListScreenController
                        self.mainNavigationController?.viewControllers = [tasksListScreenController]
                    case .validationFailed(let message):
                        let alertController = self.createAlertController(message: message)
                        self.mainNavigationController?.present(alertController, animated: true, completion: nil)
                    }
                case .failure(let error):
                    let alertController = self.createErrorAlert(error)
                    self.mainNavigationController?.present(alertController, animated: true, completion: nil)
                }
            }
        })
    }
    
    // MARK: SignInSignUpScreen
    
    weak var tasksListScreenController: TasksListScreenController?
    
    func tasksListScreenControllerAdd(_ tasksListScreenController: TasksListScreenController) {
        let createTaskScreenController = CreateTaskScreenController()
        createTaskScreenController.delegate = self
        self.createTaskScreenController = createTaskScreenController
        self.mainNavigationController?.pushViewController(createTaskScreenController, animated: true)
    }
    
    func tasksListScreenControllerTasksList(_ tasksListScreenController: TasksListScreenController, page: Int, completionHandler: @escaping (Result<[Task], Error>) -> ()) {
        delegate?.iphonePresentationTasksList(self, page: page, completionHandler: { (result) in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        })
    }
    
    func tasksListScreenControllerDetails(_ tasksListScreenController: TasksListScreenController, task: Task) {
        let taskDetailsScreenController = TaskDetailsScreenController(taskInList: task)
        taskDetailsScreenController.delegate = self
        self.taskDetailsScreenController = taskDetailsScreenController
        self.mainNavigationController?.pushViewController(taskDetailsScreenController, animated: true)
    }
    
    // MARK: TaskDetailsScreen
    
    weak var taskDetailsScreenController: TaskDetailsScreenController?
    
    func taskDetailsScreenControllerBack(_ taskDetailsScreenController: TaskDetailsScreenController) {
        mainNavigationController?.popViewController(animated: true)
    }
    
    func taskDetailsScreenControllerDetails(_ taskDetailsScreenController: TaskDetailsScreenController, taskInList: Task, completionHandler: @escaping (Task) -> ()) {
        delegate?.iphonePresentationTaskDetails(self, taskInList: taskInList, completionHandler: { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let taskDetails):
                    completionHandler(taskDetails)
                case .failure(let error):
                    let alertController = self.createErrorAlert(error)
                    self.mainNavigationController?.present(alertController, animated: true, completion: nil)
                }
            }
        })
    }
    
    func taskDetailsScreenControllerDelete(_ taskDetailsScreenController: TaskDetailsScreenController, taskDetails: Task) {
        delegate?.iphonePresentationTaskDelete(self, taskDetails: taskDetails, completionHandler: { [weak self] (error) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let error = error {
                    let alertController = self.createAlertController(message: "\(error)")
                    self.mainNavigationController?.present(alertController, animated: true, completion: nil)
                } else {
                    self.tasksListScreenController?.knowTaskWasDeleted()
                    guard let tasksListScreenController = self.tasksListScreenController else { return }
                    self.mainNavigationController?.popToViewController(tasksListScreenController, animated: true)
                }
            }
        })
    }
    
    func taskDetailsScreenControllerUpdate(_ taskDetailsScreenController: TaskDetailsScreenController, taskDetails: Task) {
        let editTaskScreenController = EditTaskScreenController(taskDetails: taskDetails)
        editTaskScreenController.delegate = self
        self.editTaskScreenController = editTaskScreenController
        self.mainNavigationController?.pushViewController(editTaskScreenController, animated: true)
    }
    
    // MARK: CreateTaskScreenController
    
    weak var createTaskScreenController: CreateTaskScreenController?
    
    func createTaskScreenControllerBack(_ createTaskScreenController: CreateTaskScreenController) {
        self.mainNavigationController?.popViewController(animated: true)
    }
    
    func createTaskScreenControllerCreate(_ createTaskScreenController: CreateTaskScreenController, _ creatingTask: CreatingTask) {
        delegate?.iphonePresentationTaskCreate(self, creatingTask: creatingTask, completionHandler: { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let createTaskResult):
                    switch createTaskResult {
                    case .success:
                        self.tasksListScreenController?.knowTaskWasCreated()
                        guard let tasksListScreenController = self.tasksListScreenController else { return }
                        self.mainNavigationController?.popToViewController(tasksListScreenController, animated: true)
                    case .validationFailed(let message):
                        let alertController = self.createAlertController(message: message)
                        self.mainNavigationController?.present(alertController, animated: true, completion: nil)
                    }
                case .failure(let error):
                    let alertController = self.createErrorAlert(error)
                    self.mainNavigationController?.present(alertController, animated: true, completion: nil)
                }
            }
        })
    }
    
    // MARK: EditTaskScreenController
    
    weak var editTaskScreenController: EditTaskScreenController?
    
    func editTaskScreenControllerBack(_ editTaskScreenController: EditTaskScreenController) {
        mainNavigationController?.popViewController(animated: true)
    }
    
    func editTaskScreenControllerEdit(_ editTaskScreenController: EditTaskScreenController, _ editingTask: Task) {
        delegate?.iphonePresentationTaskEdit(self, editingTask: editingTask, completionHandler: { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let createTaskResult):
                    switch createTaskResult {
                    case .success:
                        self.tasksListScreenController?.knowTaskWasEdited()
                        self.taskDetailsScreenController?.knowTaskWasEdited()
                        guard let taskDetailsScreenController = self.taskDetailsScreenController else { return }
                        self.mainNavigationController?.popToViewController(taskDetailsScreenController, animated: true)
                    case .validationFailed(let message):
                        let alertController = self.createAlertController(message: message)
                        self.mainNavigationController?.present(alertController, animated: true, completion: nil)
                    }
                case .failure(let error):
                    let alertController = self.createErrorAlert(error)
                    self.mainNavigationController?.present(alertController, animated: true, completion: nil)
                }
            }
        })
    }
    
}
