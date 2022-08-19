//
//  RecipesListScreenRecipeCollectionViewCell.swift
//  DoitSoftwareIosTestTaskPresentation
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import AUIKit

class TasksListScreenTaskCollectionViewCell: AUICollectionViewCell {
    // MARK: Subviews

    let titleLabel = UILabel()
    let dueByLabel = UILabel()
    let priorityLabel = UILabel()

    // MARK: Setup
    
    override func setup() {
        super.setup()
        contentView.addSubview(titleLabel)
        setupNameLabel()
        contentView.addSubview(dueByLabel)
        setupDurationLabel()
        contentView.addSubview(priorityLabel)
        priorityLabel.font = UIFont.systemFont(ofSize: 12)
    }
    
    private func setupDurationLabel() {
        dueByLabel.font = UIFont.systemFont(ofSize: 12)
    }

    private func setupNameLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        titleLabel.minimumScaleFactor = 0.5
    }

    // MARK: Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTitleLabel()
        layoutDueByLabel()
        layoutPriorityLabel()
    }

    private func layoutTitleLabel() {
        let x: CGFloat = 32
        let y: CGFloat = 8
        let availableWidth = bounds.width - 2 * x
        let availableHeight = CGFloat.greatestFiniteMagnitude
        let availableSize = CGSize(width: availableWidth, height: availableHeight)
        let size = titleLabel.sizeThatFits(availableSize)
        let origin = CGPoint(x: x, y: y)
        let frame = CGRect(origin: origin, size: size)
        titleLabel.frame = frame
    }
    
    private func layoutDueByLabel() {
        let x: CGFloat = 32
        let availableWidth = bounds.width - 2 * x
        let availableHeight = CGFloat.greatestFiniteMagnitude
        let availableSize = CGSize(width: availableWidth, height: availableHeight)
        let size = dueByLabel.sizeThatFits(availableSize)
        let y: CGFloat = bounds.height - size.height - 8
        let origin = CGPoint(x: x, y: y)
        let frame = CGRect(origin: origin, size: size)
        dueByLabel.frame = frame
    }
    
    private func layoutPriorityLabel() {
        let x: CGFloat = dueByLabel.frame.origin.x + dueByLabel.frame.size.width + 32
        let availableWidth = bounds.width - dueByLabel.frame.size.width - 32 - 32
        let availableHeight = CGFloat.greatestFiniteMagnitude
        let availableSize = CGSize(width: availableWidth, height: availableHeight)
        let size = priorityLabel.sizeThatFits(availableSize)
        let y: CGFloat = bounds.height - size.height - 8
        let origin = CGPoint(x: x, y: y)
        let frame = CGRect(origin: origin, size: size)
        priorityLabel.frame = frame
    }
}

