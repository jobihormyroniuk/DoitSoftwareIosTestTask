//
//  TasksListScreenView.swift
//  DoitSoftwareIosTestTaskPresentation
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import AUIKit

class TasksListScreenView: ScreenViewWithNavigationBar {
    // MARK: Elements

    let titleLabel = UILabel()
    let addButton: UIButton = AddButton()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: TasksListScreenCollectionViewLayout())
    let refreshControl = UIRefreshControl()

    // MARK: Setup

    override func setup() {
        super.setup()
        backgroundColor = .white
        addSubview(collectionView)
        setupCollectionView()
        addSubview(addButton)
        addButton.setTitle("+", for: .normal)
        collectionView.addSubview(refreshControl)
    }

    override func setupStatusBarView() {
        super.setupStatusBarView()
        statusBarView.backgroundColor = .gray
    }

    override func setupNavigationBarView() {
        super.setupNavigationBarView()
        navigationBarView.backgroundColor = .lightGray
        navigationBarView.addSubview(titleLabel)
    }

    private let taskCollectionViewCellIdentifier = "taskCollectionViewCellIdentifier"
    private func setupCollectionView() {
        collectionView.alwaysBounceVertical = true
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        collectionView.backgroundColor = .white
        collectionView.register(TasksListScreenTaskCollectionViewCell.self, forCellWithReuseIdentifier: taskCollectionViewCellIdentifier)
    }

    // MARK: Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutAddButton()
        layoutTitleLabel()
        layoutCollectionView()
    }

    private func layoutAddButton() {
        let width: CGFloat = 64
        let height: CGFloat = 64
        let x = bounds.width - width - 32
        let y = bounds.height - height - 32
        let frame = CGRect(x: x, y: y, width: width, height: height)
        addButton.frame = frame
    }

    private func layoutTitleLabel() {
        let availableWidth: CGFloat = navigationBarView.bounds.width - 32 * 2
        let availableHeight: CGFloat = navigationBarView.bounds.height
        let availableSize = CGSize(width: availableWidth, height: availableHeight)
        let size = titleLabel.sizeThatFits(availableSize)
        let x: CGFloat = (navigationBarView.bounds.width - size.width) / 2
        let y: CGFloat = (navigationBarView.bounds.height - size.height) / 2
        let origin = CGPoint(x: x, y: y)
        let frame = CGRect(origin: origin, size: size)
        titleLabel.frame = frame
    }

    private func layoutCollectionView() {
        let x: CGFloat = 0
        let y = navigationBarView.frame.origin.y + navigationBarView.frame.height
        let width = bounds.size.width
        let height = bounds.height - y
        let frame = CGRect(x: x, y: y, width: width, height: height)
        collectionView.frame = frame
    }

    // MARK: Cells

    func taskCollectionViewCell(_ indexPath: IndexPath) -> TasksListScreenTaskCollectionViewCell! {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: taskCollectionViewCellIdentifier, for: indexPath) as? TasksListScreenTaskCollectionViewCell
        return cell
    }
}

private class AddButton: AUIButton {
    override func setup() {
        super.setup()
        backgroundColor = .gray
        layer.cornerRadius = 2
        layer.masksToBounds = true
    }
    
    override var isHighlighted: Bool {
        willSet {
            alpha = newValue ? 0.6 : 1.0
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = bounds.width / 2
    }
}
