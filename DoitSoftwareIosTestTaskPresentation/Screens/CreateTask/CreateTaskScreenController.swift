//
//  CreateTaskScreenController.swift
//  DoitSoftwareIosTestTaskPresentation
//
//  Created by Ihor Myroniuk on 27.12.2020.
//

import AUIKit
import AFoundation

protocol CreateTaskScreenControllerDelegate: class {
    func createTaskScreenControllerBack(_ createTaskScreenController: CreateTaskScreenController)
    func createTaskScreenControllerCreate(_ createTaskScreenController: CreateTaskScreenController, _ creatingTask: CreatingTask)
}

class CreateTaskScreenController: UIViewController, AUITextViewControllerDidChangeTextObserver, AUIControlControllerDidValueChangedObserver, AUITextFieldControllerDidBeginEditingObserver {
    // MARK: AddRecipeScreen

    weak var delegate: CreateTaskScreenControllerDelegate?
    
    private lazy var dueByDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "eeee dd MMMM, yyyy"
        return dateFormatter
    }()

    // MARK: Localization

    private let localizer: Localizer = {
        let bundle = Bundle(for: CreateTaskScreenController.self)
        let tableName = "CreateTaskScreenStrings"
        let textLocalizer = TableNameBundleTextLocalizer(tableName: tableName, bundle: bundle)
        let localizator = CompositeLocalizer(textLocalization: textLocalizer)
        return localizator
    }()

    // MARK: CreateTaskScreenView
    
    override func loadView() {
        view = CreateTaskScreenView()
    }

    private var createTaskScreenView: CreateTaskScreenView! {
        return view as? CreateTaskScreenView
    }

    private var dueBy: Date?
    
    // MARL: Controllers

    private let titleTextViewController = AUIEmptyTextViewController()
    private let tapGestureRecognizer = UITapGestureRecognizer()
    private let dueByFieldViewController = AUIEmptyTextFieldController()
    private let dueByDatePeckerController = AUIEmptyDateTimePickerController()

    // MARK: Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTaskScreenView.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.addTarget(self, action: #selector(tapGestureRecognizerAction))
        titleTextViewController.textView = createTaskScreenView.taskTitleTextInputView.textView
        titleTextViewController.addDidChangeTextObserver(self)
        createTaskScreenView.backButton.addTarget(self, action: #selector(backButtonTouchUpInside), for: .touchUpInside)
        createTaskScreenView.addButton.addTarget(self, action: #selector(createButtonTouchUpInside), for: .touchUpInside)
        createTaskScreenView.priorityButtons.forEach({ $0.addTarget(self, action: #selector(priorityButtonTouchUpInside(_:)), for: .touchUpInside) })
        dueByFieldViewController.textField = createTaskScreenView.dueByTextInputView.textField
        dueByFieldViewController.addDidBeginEditingObserver(self)
        dueByDatePeckerController.mode = .dateAndTime
        dueByDatePeckerController.datePicker = createTaskScreenView.dueByDatePicker
        dueByDatePeckerController.minimumDate = Date()
        dueByDatePeckerController.addDidValueChangedObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object:nil)
        setContent()
    }
    
    // MARK: Events
    
    @objc private func keyboardWillChangeFrame(notification: NSNotification) {
        guard let height = ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]) as? NSValue)?.cgRectValue.origin.y else { return }
        view.frame.size.height = height
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

    
    @objc private func tapGestureRecognizerAction() {
        view.endEditing(true)
    }

    func textViewControllerDidChangeText(_ textViewController: AUITextViewController) {
        createTaskScreenView.setNeedsLayout()
        createTaskScreenView.layoutIfNeeded()
    }
    
    func textFieldControllerDidBeginEditing(_ textFieldController: AUITextFieldController) {
        if dueByFieldViewController === textFieldController {
            dueByFieldViewController.text = dueByDateFormatter.string(from: dueByDatePeckerController.date)
            dueBy = dueByDatePeckerController.date
        }
    }
    
    @objc private func backButtonTouchUpInside() {
        delegate?.createTaskScreenControllerBack(self)
    }
    
    @objc private func priorityButtonTouchUpInside(_ button: UIButton) {
        createTaskScreenView.selectPriorityButton(button)
    }
    
    func controlControllerDidValueChanged(_ controlController: AUIControlController) {
        if dueByDatePeckerController === controlController {
            dueByFieldViewController.text = dueByDateFormatter.string(from: dueByDatePeckerController.date)
            dueBy = dueByDatePeckerController.date
        }
    }

    // MARK: Actions
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    @objc private func back() {
        delegate?.createTaskScreenControllerBack(self)
    }

    @objc private func createButtonTouchUpInside() {
        guard let title = titleTextViewController.text, !title.isEmpty else { return }
        let optionalPriority: TaskPriority?
        if createTaskScreenView.lowPriorityButton.isSelected {
            optionalPriority = .low
        } else if createTaskScreenView.mediumPriorityButton.isSelected {
            optionalPriority = .medium
        } else if createTaskScreenView.highPriorityButton.isSelected {
            optionalPriority = .high
        } else {
            optionalPriority = nil
        }
        guard let priority = optionalPriority else { return }
        guard let dueBy = dueBy else { return }
        let creatingTask = CreatingTask(title: title, dueBy: dueBy, priority: priority)
        delegate?.createTaskScreenControllerCreate(self, creatingTask)
    }

    // MARK: Content

    private func setContent() {
        createTaskScreenView.backButton.setTitle(localizer.localizeText("back"), for: .normal)
        createTaskScreenView.addButton.setTitle(localizer.localizeText("create"), for: .normal)
        createTaskScreenView.titleLabel.text = localizer.localizeText("title")
        createTaskScreenView.taskTitleLabel.text = localizer.localizeText("taskTitle")
        createTaskScreenView.priorityTitleLabel.text = localizer.localizeText("priorityTitle")
        createTaskScreenView.lowPriorityButton.setTitle(localizer.localizeText("lowPriority"), for: .normal)
        createTaskScreenView.mediumPriorityButton.setTitle(localizer.localizeText("mediumPriority"), for: .normal)
        createTaskScreenView.highPriorityButton.setTitle(localizer.localizeText("highPriority"), for: .normal)
        createTaskScreenView.dueByTitleLabel.text = localizer.localizeText("dueByTitle")
    }

}
