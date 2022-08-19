//
//  CreateTaskScreenView.swift
//  DoitSoftwareIosTestTaskPresentation
//
//  Created by Ihor Myroniuk on 27.12.2020.
//

import AUIKit

class CreateTaskScreenView: ScreenViewWithNavigationBar {

    // MARK: Subview

    let titleLabel = UILabel()
    let addButton = AlphaHighlightButton()
    let backButton = AlphaHighlightButton()
    let scrollView = UIScrollView()
    let taskTitleLabel = UILabel()
    let taskTitleTextInputView: AUITextViewTextInputView = TextViewInputView()
    let taskTitleSeparatorLayer = CALayer()
    let priorityTitleLabel = UILabel()
    let priorityButtons: [UIButton] = [PriorityButton(), PriorityButton(), PriorityButton()]
    var lowPriorityButton: UIButton { return priorityButtons[0] }
    var mediumPriorityButton: UIButton { return priorityButtons[1] }
    var highPriorityButton: UIButton { return priorityButtons[2] }
    let prioritySeparatorLayer = CALayer()
    let dueByTitleLabel = UILabel()
    let dueByTextInputView: AUITextFieldTextInputView = TextFieldInputView()
    let dueByDatePicker = UIDatePicker()

    // MARK: Setup

    override func setup() {
        super.setup()
        backgroundColor = .white
        addSubview(scrollView)
        setupScrollView()
    }

    override func setupStatusBarView() {
        super.setupStatusBarView()
        statusBarView.backgroundColor = .gray
    }

    override func setupNavigationBarView() {
        super.setupNavigationBarView()
        navigationBarView.backgroundColor = .lightGray
        navigationBarView.addSubview(backButton)
        navigationBarView.addSubview(addButton)
        navigationBarView.addSubview(titleLabel)
    }

    private func setupScrollView() {
        scrollView.alwaysBounceVertical = true
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        scrollView.addSubview(taskTitleLabel)
        scrollView.addSubview(taskTitleTextInputView)
        scrollView.layer.addSublayer(taskTitleSeparatorLayer)
        taskTitleSeparatorLayer.backgroundColor = UIColor.gray.cgColor
        scrollView.addSubview(priorityTitleLabel)
        priorityButtons.forEach({ scrollView.addSubview($0) })
        scrollView.layer.addSublayer(prioritySeparatorLayer)
        prioritySeparatorLayer.backgroundColor = UIColor.gray.cgColor
        scrollView.addSubview(dueByTitleLabel)
        scrollView.addSubview(dueByTextInputView)
        dueByTextInputView.textField.inputView = dueByDatePicker
        dueByDatePicker.preferredDatePickerStyle = .wheels
    }

    // MARK: Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutBackButton()
        layoutAddButton()
        layoutTitleLabel()
        layoutScrollView()
        layoutTaskTitleLabel()
        layoutTaskTitleTextInput()
        layoutTaskTitleSeparatorLayer()
        layoutPriorityTitleLabel()
        layoutPriorityButtons()
        layoutPrioritySeparatorLayer()
        layoutDueByTitleLabel()
        layoutDueByTextInputView()
        setScrollViewContentSize()
    }

    private func layoutBackButton() {
        let availableHeight = navigationBarView.bounds.height
        let availableWidth = navigationBarView.bounds.width / 4
        let availableSize = CGSize(width: availableWidth, height: availableHeight)
        let size = backButton.sizeThatFits(availableSize)
        let width: CGFloat = size.width
        let height: CGFloat = size.height
        let x: CGFloat = 8
        let y: CGFloat = (navigationBarView.bounds.height - height) / 2
        let frame = CGRect(x: x, y: y, width: width, height: height)
        backButton.frame = frame
    }

    private func layoutAddButton() {
        let possibleHeight = navigationBarView.bounds.height
        let possibleWidth = navigationBarView.bounds.width / 4
        let possibleSize = CGSize(width: possibleWidth, height: possibleHeight)
        let size = addButton.sizeThatFits(possibleSize)
        let width: CGFloat = size.width
        let height: CGFloat = size.height
        let x: CGFloat = navigationBarView.bounds.width - 8 - width
        let y: CGFloat = (navigationBarView.bounds.height - height) / 2
        let frame = CGRect(x: x, y: y, width: width, height: height)
        addButton.frame = frame
    }

    private func layoutTitleLabel() {
        let possibleWidth: CGFloat = navigationBarView.bounds.width - 2 * (navigationBarView.bounds.width - addButton.frame.origin.x + 8)
        let possibleHeight: CGFloat = navigationBarView.bounds.height
        let possibleSize = CGSize(width: possibleWidth, height: possibleHeight)
        var size = titleLabel.sizeThatFits(possibleSize)
        if size.height > possibleHeight {
            size.height = possibleHeight
        }
        let x: CGFloat = (navigationBarView.bounds.width - size.width) / 2
        let y: CGFloat = (navigationBarView.bounds.height - size.height) / 2
        let origin = CGPoint(x: x, y: y)
        let frame = CGRect(origin: origin, size: size)
        titleLabel.frame = frame
    }

    private func layoutScrollView() {
        let x: CGFloat = 0
        let y = navigationBarView.frame.origin.y + navigationBarView.frame.height
        let width = bounds.size.width
        let height = bounds.height - y
        let frame = CGRect(x: x, y: y, width: width, height: height)
        scrollView.frame = frame
    }
    
    private func layoutTaskTitleLabel() {
        let x: CGFloat = 32
        let y: CGFloat = 16
        let availableWidth = bounds.width - 2 * x
        let availableHeight = CGFloat.greatestFiniteMagnitude
        let availableSize = CGSize(width: availableWidth, height: availableHeight)
        let size = taskTitleLabel.sizeThatFits(availableSize)
        let origin = CGPoint(x: x, y: y)
        let frame = CGRect(origin: origin, size: size)
        taskTitleLabel.frame = frame
    }

    private func layoutTaskTitleTextInput() {
        let x: CGFloat = 32
        let y: CGFloat = taskTitleLabel.frame.origin.y + taskTitleLabel.frame.size.height + 16
        let origin = CGPoint(x: x, y: y)
        let possibleHeight: CGFloat = CGFloat.greatestFiniteMagnitude
        let possibleWidth = scrollView.bounds.width - x * 2
        let possibleSize = CGSize(width: possibleWidth, height: possibleHeight)
        let size = taskTitleTextInputView.sizeThatFits(possibleSize)
        let frame = CGRect(origin: origin, size: size)
        taskTitleTextInputView.frame = frame
        taskTitleTextInputView.setNeedsLayout()
        taskTitleTextInputView.layoutIfNeeded()
    }
    
    private func layoutTaskTitleSeparatorLayer() {
        let x: CGFloat = 0
        let y: CGFloat = taskTitleTextInputView.frame.origin.y + taskTitleTextInputView.frame.size.height + 16
        let height: CGFloat = 1
        let width = bounds.width
        let frame = CGRect(x: x, y: y, width: width, height: height)
        taskTitleSeparatorLayer.frame = frame
    }
    
    private func layoutPriorityTitleLabel() {
        let x: CGFloat = 32
        let y: CGFloat = taskTitleSeparatorLayer.frame.origin.y + taskTitleSeparatorLayer.frame.size.height + 16
        let availableWidth = bounds.width - 2 * x
        let availableHeight = CGFloat.greatestFiniteMagnitude
        let availableSize = CGSize(width: availableWidth, height: availableHeight)
        let size = priorityTitleLabel.sizeThatFits(availableSize)
        let origin = CGPoint(x: x, y: y)
        let frame = CGRect(origin: origin, size: size)
        priorityTitleLabel.frame = frame
    }
    
    private func layoutPriorityButtons() {
        let space: CGFloat = 32
        let y: CGFloat = priorityTitleLabel.frame.origin.y + priorityTitleLabel.frame.size.height + 16
        let width: CGFloat = ((bounds.width - CGFloat(2 * 32)) - space * CGFloat(priorityButtons.count - 1)) / CGFloat(priorityButtons.count)
        let height: CGFloat = 32
        for index in 0..<priorityButtons.count {
            let x = CGFloat(32) + (width + space) * CGFloat(index)
            let frame = CGRect(x: x, y: y, width: width, height: height)
            priorityButtons[index].frame = frame
        }
    }
    
    private func layoutPrioritySeparatorLayer() {
        let x: CGFloat = 0
        let y: CGFloat = priorityButtons[0].frame.origin.y + priorityButtons[0].frame.size.height + 16
        let height: CGFloat = 1
        let width = bounds.width
        let frame = CGRect(x: x, y: y, width: width, height: height)
        prioritySeparatorLayer.frame = frame
    }
    
    private func layoutDueByTitleLabel() {
        let x: CGFloat = 32
        let y: CGFloat = prioritySeparatorLayer.frame.origin.y + prioritySeparatorLayer.frame.size.height + 16
        let availableWidth = bounds.width - 2 * x
        let availableHeight = CGFloat.greatestFiniteMagnitude
        let availableSize = CGSize(width: availableWidth, height: availableHeight)
        let size = dueByTitleLabel.sizeThatFits(availableSize)
        let origin = CGPoint(x: x, y: y)
        let frame = CGRect(origin: origin, size: size)
        dueByTitleLabel.frame = frame
    }
    
    private func layoutDueByTextInputView() {
        let x: CGFloat = 32
        let y: CGFloat = dueByTitleLabel.frame.origin.y + dueByTitleLabel.frame.size.height + 16
        let origin = CGPoint(x: x, y: y)
        let possibleHeight: CGFloat = CGFloat.greatestFiniteMagnitude
        let possibleWidth = scrollView.bounds.width - x * 2
        let possibleSize = CGSize(width: possibleWidth, height: possibleHeight)
        let size = taskTitleTextInputView.sizeThatFits(possibleSize)
        let frame = CGRect(origin: origin, size: size)
        dueByTextInputView.frame = frame
        dueByTextInputView.setNeedsLayout()
        dueByTextInputView.layoutIfNeeded()
    }

    private func setScrollViewContentSize() {
        let width = scrollView.frame.size.width
        let height = dueByTextInputView.frame.origin.y + dueByTextInputView.frame.height + 30
        let size = CGSize(width: width, height: height)
        scrollView.contentSize = size
    }
    
    // MARK:
    
    func selectPriorityButton(_ selectedButton: UIButton) {
        for button in priorityButtons {
            if selectedButton == button {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    }
}

private class TextViewInputView: AUIView, AUITextViewTextInputView {
    // MARK: Subviews

    let textView = UITextView()

    // MARK: Setup

    override func setup() {
        super.setup()
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.cornerRadius = 2
        layer.borderColor = UIColor.gray.cgColor
        addSubview(textView)
        setupTextView()
    }

    private func setupTextView() {
        textView.isScrollEnabled = false
        textView.alwaysBounceVertical = false
        textView.bounces = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textContainer.lineFragmentPadding = 0
    }

    // MARK: Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTextView()
    }

    private func layoutTextView() {
        textView.frame = bounds
    }

    // MARK: Size

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let textViewSize = textView.sizeThatFits(size)
        let sizeThatFits = CGSize(width: size.width, height: textViewSize.height)
        return sizeThatFits
    }
}

private class PriorityButton: AlphaHighlightButton {
    override func setup() {
        super.setup()
        setTitleColor(.black, for: .normal)
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.cornerRadius = 2
        layer.borderColor = UIColor.gray.cgColor
    }
    
    override var isSelected: Bool {
        willSet {
            backgroundColor = newValue ? .lightGray : .clear
        }
    }
}

private class TextFieldInputView: AUIView, AUITextFieldTextInputView {
    // MARK: Subviews

    let textField = UITextField()

    // MARK: Setup

    override func setup() {
        super.setup()
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.cornerRadius = 2
        layer.borderColor = UIColor.gray.cgColor
        tintColor = .clear
        addSubview(textField)
    }

    // MARK: Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTextView()
    }

    private func layoutTextView() {
        textField.frame = bounds
    }

    // MARK: Size

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let textViewSize = textField.sizeThatFits(size)
        let sizeThatFits = CGSize(width: size.width, height: textViewSize.height)
        return sizeThatFits
    }
}
