//
//  TaskDetailsScreenController.swift
//  DoitSoftwareIosTestTaskPresentation
//
//  Created by Ihor Myroniuk on 27.12.2020.
//

import AUIKit
import AFoundation

protocol TaskDetailsScreenControllerDelegate: class {
    func taskDetailsScreenControllerBack(_ taskDetailsScreenController: TaskDetailsScreenController)
    func taskDetailsScreenControllerDetails(_ taskDetailsScreenController: TaskDetailsScreenController, taskInList: Task, completionHandler: @escaping (Task) -> ())
    func taskDetailsScreenControllerDelete(_ taskDetailsScreenController: TaskDetailsScreenController, taskDetails: Task)
    func taskDetailsScreenControllerUpdate(_ taskDetailsScreenController: TaskDetailsScreenController, taskDetails: Task)
}

class TaskDetailsScreenController: UIViewController {
    
    // MARK: RecipeInDetailsScreen
    
    weak var delegate: TaskDetailsScreenControllerDelegate?
    
    func knowTaskWasEdited() {
        refresh()
    }
    
    // MARK: Localization

    private let localizer: Localizer = {
        let bundle = Bundle(for: TaskDetailsScreenController.self)
        let tableName = "TaskDetailsScreenStrings"
        let textLocalizer = TableNameBundleTextLocalizer(tableName: tableName, bundle: bundle)
        let localizator = CompositeLocalizer(textLocalization: textLocalizer)
        return localizator
    }()
    
    private lazy var dueByDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "eeee dd MMMM, yyyy"
        return dateFormatter
    }()
    
    // MARK: Data
    
    private var taskInList: Task
    private var taskDetails: Task?
    
    // MARK: Initializer
    
    init(taskInList: Task) {
        self.taskInList = taskInList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: TaskDetailsScreenView
    
    override func loadView() {
        view = TaskDetailsScreenView()
    }

    private var taskDetailsScreenView: TaskDetailsScreenView! {
        return view as? TaskDetailsScreenView
    }
    
    // MARK: Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskDetailsScreenView.backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        taskDetailsScreenView.deleteButton.addTarget(self, action: #selector(_delete), for: .touchUpInside)
        taskDetailsScreenView.updateButton.addTarget(self, action: #selector(update), for: .touchUpInside)
        setContent()
        setTaskDetailsContent(taskInList)
        refresh()
    }
    
    // MARK: Actions
    
    @objc private func back() {
        delegate?.taskDetailsScreenControllerBack(self)
    }

    @objc private func _delete() {
        guard let taskDetails = taskDetails else { return }
        delegate?.taskDetailsScreenControllerDelete(self, taskDetails: taskDetails)
    }
    
    @objc private func update() {
        guard let taskDetails = taskDetails else { return }
        delegate?.taskDetailsScreenControllerUpdate(self, taskDetails: taskDetails)
    }
    
    private func refresh() {
        delegate?.taskDetailsScreenControllerDetails(self, taskInList: taskInList, completionHandler: { [weak self] (taskDetails) in
            guard let self = self else { return }
            self.taskDetails = taskDetails
            self.setTaskDetailsContent(taskDetails)
            self.taskDetailsScreenView.setNeedsLayout()
            self.taskDetailsScreenView.layoutIfNeeded()
        })
    }
    
    // MARK: Content

    private func setContent() {
        taskDetailsScreenView.titleLabel.text = localizer.localizeText("title")
        taskDetailsScreenView.backButton.setTitle(localizer.localizeText("back"), for: .normal)
        taskDetailsScreenView.deleteButton.setTitle(localizer.localizeText("delete"), for: .normal)
        taskDetailsScreenView.updateButton.setTitle(localizer.localizeText("update"), for: .normal)
        taskDetailsScreenView.priorityTitleLabel.text = localizer.localizeText("priorityTitle")
    }

    private func setTaskDetailsContent(_ task: Task) {
        taskDetailsScreenView.taskTitleLabel.text = task.title
        taskDetailsScreenView.dueByLabel.text = "\(dueByDateFormatter.string(from: task.dueBy))"
        taskDetailsScreenView.priorityLabel.text = task.priority.rawValue
    }
}
