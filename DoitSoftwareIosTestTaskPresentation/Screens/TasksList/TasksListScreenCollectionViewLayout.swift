//
//  RecipesListScreenCollectionViewLayout.swift
//  DoitSoftwareIosTestTaskPresentation
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import AUIKit

final class TasksListScreenCollectionViewLayout: AUICollectionViewLayout {
    // MARK: Setup
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let separatorCollectionReusableViewIdentifier = "separatorCollectionReusableViewIdentifier"
    func setup() {
        self.register(SeparatorCollectionReusableView.self, forDecorationViewOfKind: separatorCollectionReusableViewIdentifier)
    }
    
    private var y = 0
    override func prepare() {
        super.prepare()
        y = 0
        prepareTasks()
    }
    
    private var tasksLayoutAttributes: [UICollectionViewLayoutAttributes] = []
    private var tasksSeparatorsLayoutAttributes: [UICollectionViewLayoutAttributes] = []
    private func prepareTasks() {
        tasksLayoutAttributes = []
        tasksSeparatorsLayoutAttributes = []
        guard let collectionView = collectionView else { return }
        let section = 0
        let numberOfItems = collectionView.numberOfItems(inSection: section)
        guard numberOfItems > 0 else { return }
        let bounds = collectionView.bounds
        let boundsWidth = Int(bounds.width)
        let x = 0
        let width = boundsWidth - x * 2
        let spacing = 0
        y += spacing
        let height = 64
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(item: item, section: section)
            let recipeLayoutAttribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            recipeLayoutAttribute.frame = CGRect(x: x, y: y, width: width, height: height)
            tasksLayoutAttributes.append(recipeLayoutAttribute)
            y += height + spacing
            let recipeSeparatorLayoutAttribute = UICollectionViewLayoutAttributes(forDecorationViewOfKind: separatorCollectionReusableViewIdentifier, with: indexPath)
            recipeSeparatorLayoutAttribute.frame = CGRect(x: x, y: y, width: width, height: 1)
            tasksSeparatorsLayoutAttributes.append(recipeSeparatorLayoutAttribute)
            y += spacing + 1
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = tasksLayoutAttributes + tasksSeparatorsLayoutAttributes
        let layoutAttributesInRect = layoutAttributes.filter({ $0.frame.intersects(rect) })
        return layoutAttributesInRect
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let section = indexPath.section
        let item = indexPath.item
        if section == 0 {
            return tasksLayoutAttributes[item]
        }
        return nil
    }
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
        if elementKind == separatorCollectionReusableViewIdentifier {
            return tasksSeparatorsLayoutAttributes[indexPath.item]
        }
        return nil
    }
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return .zero }
        let width = Int(collectionView.bounds.size.width)
        let height = y
        let size = CGSize(width: width, height: height)
        return size
    }
}

private class SeparatorCollectionReusableView: AUICollectionReusableView {
    override func setup() {
        super.setup()
        backgroundColor = .lightGray
    }
}

