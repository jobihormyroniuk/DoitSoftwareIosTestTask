//
//  TasksListScreenController.swift
//  DoitSoftwareIosTestTaskPresentation
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import AUIKit
import AFoundation

protocol TasksListScreenControllerDelegate: class {
    func tasksListScreenControllerAdd(_ tasksListScreenController: TasksListScreenController)
    func tasksListScreenControllerTasksList(_ tasksListScreenController: TasksListScreenController, page: Int, completionHandler: @escaping (Result<[Task], Error>) -> ())
    func tasksListScreenControllerDetails(_ tasksListScreenController: TasksListScreenController, task: Task)
}

class TasksListScreenController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: RecipesListScreen

    weak var delegate: TasksListScreenControllerDelegate?
    
    func knowTaskWasDeleted() {
        refreshList()
    }
    
    func knowTaskWasCreated() {
        refreshList()
    }
    
    func knowTaskWasEdited() {
        refreshList()
    }

    // MARK: Data

    private var tasks: [Task] = []
    private var page: Int = 0
    private var lastDisplayedTaskIndex: Int?
    private lazy var dueByDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter
    }()

    // MARK: Localization

    private let localizer: Localizer = {
        let bundle = Bundle(for: TasksListScreenController.self)
        let tableName = "TasksListScreenStrings"
        let textLocalizer = TableNameBundleTextLocalizer(tableName: tableName, bundle: bundle)
        let localizator = CompositeLocalizer(textLocalization: textLocalizer)
        return localizator
    }()

    // MARK: RecipesListScreenView
    
    override func loadView() {
        view = TasksListScreenView()
    }

    private var tasksListScreenView: TasksListScreenView! {
        return view as? TasksListScreenView
    }

    // MARK: Events

    override func viewDidLoad() {
        super.viewDidLoad()
        tasksListScreenView.collectionView.dataSource = self
        tasksListScreenView.collectionView.delegate = self
        tasksListScreenView.addButton.addTarget(self, action: #selector(addButtonTouchUpInside), for: .touchUpInside)
        tasksListScreenView.refreshControl.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        setContent()
        refreshList()
    }
    
    @objc private func addButtonTouchUpInside() {
        add()
    }
    
    @objc private func refreshControlValueChanged() {
        refreshList()
    }

    // MARK: Actions
    
    private func refreshList() {
        lastDisplayedTaskIndex = nil
        page = 1
        delegate?.tasksListScreenControllerTasksList(self, page: page, completionHandler: { [weak self] (result) in
            guard let self = self else { return }
            self.tasksListScreenView.refreshControl.endRefreshing()
            switch result {
            case .success(let tasks):
                self.tasks = tasks
                self.page += 1
                self.tasksListScreenView.collectionView.reloadData()
            case .failure:
                break
            }
        })
    }
    
    private func loadList() {
        delegate?.tasksListScreenControllerTasksList(self, page: page, completionHandler: { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let tasks):
                self.tasks.append(contentsOf: tasks)
                self.page += 1
                self.tasksListScreenView.collectionView.reloadData()
            case .failure:
                break
            }
        })
    }
    
    private func willDisplayTaskAtIndex(_ index: Int) {
        if index > lastDisplayedTaskIndex ?? -1 {
            lastDisplayedTaskIndex = index
            if index  == tasks.count - 1 {
                loadList()
            }
        }
    }

    private func add() {
        delegate?.tasksListScreenControllerAdd(self)
    }

    // MARK: Content

    private func setContent() {
        tasksListScreenView.titleLabel.text = localizer.localizeText("title")
    }

    // MARK: UICollectionViewDataSource, UICollectionViewDelegate

    let tasksSection = 0
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case tasksSection:
            return tasks.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        let item = indexPath.item
        switch section {
        case tasksSection:
            let task = tasks[item]
            let cell: TasksListScreenTaskCollectionViewCell = tasksListScreenView.taskCollectionViewCell(indexPath)
            cell.titleLabel.text = task.title
            cell.dueByLabel.text = localizer.localizeText("taskDueTo", "\(dueByDateFormatter.string(from: task.dueBy))")
            cell.priorityLabel.text = task.priority.rawValue
            return cell
        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let section = indexPath.section
        let item = indexPath.item
        switch section {
        case tasksSection:
            willDisplayTaskAtIndex(item)
            break
        default:
            break
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = indexPath.section
        switch section {
        case tasksSection:
            let task = tasks[indexPath.item]
            delegate?.tasksListScreenControllerDetails(self, task: task)
        default:
            break
        }
    }
}
