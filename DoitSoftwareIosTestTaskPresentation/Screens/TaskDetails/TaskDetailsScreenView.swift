//
//  TaskDetailsScreenView.swift
//  DoitSoftwareIosTestTaskPresentation
//
//  Created by Ihor Myroniuk on 27.12.2020.
//

import AUIKit

class TaskDetailsScreenView: ScreenViewWithNavigationBar, UIScrollViewDelegate {
    
    // MARK: Subviews

    let titleLabel = UILabel()
    let deleteButton = AlphaHighlightButton()
    let updateButton = AlphaHighlightButton()
    let backButton = AlphaHighlightButton()
    let scrollView = UIScrollView()
    let taskTitleLabel = UILabel()
    let dueByLabel = UILabel()
    let taskTitleDueByBackgroundLayer = CALayer()
    let priorityTitleLabel = UILabel()
    let priorityLabel = UILabel()
   
    
    // MARK: Setup
    
    override func setup() {
        super.setup()
        backgroundColor = .white
        insertSubview(scrollView, belowSubview: statusBarView)
        setupScrollView()
        addSubview(deleteButton)
        deleteButton.backgroundColor = .lightGray
    }

    override func setupStatusBarView() {
        super.setupStatusBarView()
        statusBarView.backgroundColor = .gray
    }

    override func setupNavigationBarView() {
        super.setupNavigationBarView()
        navigationBarView.backgroundColor = .lightGray
        navigationBarView.addSubview(backButton)
        navigationBarView.addSubview(updateButton)
        navigationBarView.addSubview(titleLabel)
    }


    private func setupScrollView() {
        scrollView.alwaysBounceVertical = true
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        scrollView.layer.addSublayer(taskTitleDueByBackgroundLayer)
        taskTitleDueByBackgroundLayer.backgroundColor = UIColor.lightGray.cgColor
        scrollView.addSubview(taskTitleLabel)
        taskTitleLabel.numberOfLines = 0
        scrollView.addSubview(dueByLabel)
        scrollView.addSubview(priorityTitleLabel)
        scrollView.addSubview(priorityLabel)
    }
    
    // MARK: Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutBackButton()
        layoutDeleteButton()
        layoutUpdateButton()
        layoutTitleLabel()
        layoutScrollView()
        
        layoutTaskTitleLabel()
        layoutDueByLabel()
        layoutTaskTitleDueByBackgroundLayer()
        layoutPriorityTitleLabel()
        layoutPriorityLabel()
        
        setScrollViewContentSize()
    }

    private func layoutBackButton() {
        let possibleHeight = navigationBarView.bounds.height
        let possibleWidth = navigationBarView.bounds.width / 4
        let possibleSize = CGSize(width: possibleWidth, height: possibleHeight)
        let size = backButton.sizeThatFits(possibleSize)
        let width: CGFloat = size.width
        let height: CGFloat = size.height
        let x: CGFloat = 8
        let y: CGFloat = (navigationBarView.bounds.height - height) / 2
        let frame = CGRect(x: x, y: y, width: width, height: height)
        backButton.frame = frame
    }
    
    private func layoutUpdateButton() {
        let possibleHeight = navigationBarView.bounds.height
        let possibleWidth = navigationBarView.bounds.width / 4
        let possibleSize = CGSize(width: possibleWidth, height: possibleHeight)
        let size = updateButton.sizeThatFits(possibleSize)
        let width: CGFloat = size.width
        let height: CGFloat = size.height
        let x: CGFloat = navigationBarView.bounds.width - 8 - width
        let y: CGFloat = (navigationBarView.bounds.height - height) / 2
        let frame = CGRect(x: x, y: y, width: width, height: height)
        updateButton.frame = frame
    }

    private func layoutTitleLabel() {
        let availableWidth = navigationBarView.bounds.width - 2 * (navigationBarView.bounds.width - deleteButton.frame.origin.x + 8)
        let availableHeight = navigationBarView.bounds.height
        let availableSize = CGSize(width: availableWidth, height: availableHeight)
        let size = titleLabel.sizeThatFits(availableSize)
        let x: CGFloat = (navigationBarView.bounds.width - size.width) / 2
        let y: CGFloat = (navigationBarView.bounds.height - size.height) / 2
        let origin = CGPoint(x: x, y: y)
        let frame = CGRect(origin: origin, size: size)
        titleLabel.frame = frame
    }
    
    private func layoutDeleteButton() {
        let width = bounds.width
        let height: CGFloat = 48
        let x: CGFloat = 0
        let y: CGFloat = bounds.height - height
        let frame = CGRect(x: x, y: y, width: width, height: height)
        deleteButton.frame = frame
    }
    
    private func layoutScrollView() {
        let x: CGFloat = 0
        let y: CGFloat = navigationBarView.frame.origin.y + navigationBarView.frame.size.height
        let width = bounds.size.width
        let height = bounds.height - y - deleteButton.frame.size.height
        let frame = CGRect(x: x, y: y, width: width, height: height)
        scrollView.frame = frame
    }
    
    private func layoutTaskTitleLabel() {
        let x: CGFloat = 32
        let y: CGFloat = 32
        let availableWidth = bounds.width - 32 * 2
        let availableHeight = CGFloat.greatestFiniteMagnitude
        let availableSize = CGSize(width: availableWidth, height: availableHeight)
        let size = taskTitleLabel.sizeThatFits(availableSize)
        let origin = CGPoint(x: x, y: y)
        let frame = CGRect(origin: origin, size: size)
        taskTitleLabel.frame = frame
    }
    
    private func layoutDueByLabel() {
        let x: CGFloat = 32
        let y: CGFloat = taskTitleLabel.frame.origin.y + taskTitleLabel.frame.size.height
        let availableWidth = bounds.width - 32 * 2
        let availableHeight = CGFloat.greatestFiniteMagnitude
        let availableSize = CGSize(width: availableWidth, height: availableHeight)
        let size = dueByLabel.sizeThatFits(availableSize)
        let origin = CGPoint(x: x, y: y)
        let frame = CGRect(origin: origin, size: size)
        dueByLabel.frame = frame
    }
    
    private func layoutTaskTitleDueByBackgroundLayer() {
        let x: CGFloat = 0
        let y: CGFloat = taskTitleLabel.frame.origin.y - 16
        let width = bounds.width
        let height = (dueByLabel.frame.origin.y + dueByLabel.frame.size.height - y) + 16
        let frame = CGRect(x: x, y: y, width: width, height: height)
        taskTitleDueByBackgroundLayer.frame = frame
    }
    
    private func layoutPriorityTitleLabel() {
        let x: CGFloat = 32
        let y: CGFloat = taskTitleDueByBackgroundLayer.frame.origin.y + taskTitleDueByBackgroundLayer.frame.size.height + 16
        let availableWidth = (bounds.width - 32) / 2
        let availableHeight = CGFloat.greatestFiniteMagnitude
        let availableSize = CGSize(width: availableWidth, height: availableHeight)
        let size = priorityTitleLabel.sizeThatFits(availableSize)
        let origin = CGPoint(x: x, y: y)
        let frame = CGRect(origin: origin, size: size)
        priorityTitleLabel.frame = frame
    }
    
    private func layoutPriorityLabel() {
        let y: CGFloat = taskTitleDueByBackgroundLayer.frame.origin.y + taskTitleDueByBackgroundLayer.frame.size.height + 16
        let availableWidth = (bounds.width - 32) / 2
        let availableHeight = CGFloat.greatestFiniteMagnitude
        let availableSize = CGSize(width: availableWidth, height: availableHeight)
        let size = priorityLabel.sizeThatFits(availableSize)
        let x: CGFloat = bounds.width - 32 - size.width
        let origin = CGPoint(x: x, y: y)
        let frame = CGRect(origin: origin, size: size)
        priorityLabel.frame = frame
    }
    
    private func setScrollViewContentSize() {
        let width = scrollView.frame.size.width
        let height: CGFloat = priorityLabel.frame.origin.y + priorityLabel.frame.size.height
        let size = CGSize(width: width, height: height)
        scrollView.contentSize = size
    }
}

class AlphaHighlightButton: AUIButton {
    // MARK: Settings
    
    override var isHighlighted: Bool {
        willSet {
            if newValue {
                highlight()
            } else {
                unhighlight()
            }
        }
    }
    
    private func highlight() {
        alpha = 0.4
    }
    
    private func unhighlight() {
        alpha = 1
    }
}
