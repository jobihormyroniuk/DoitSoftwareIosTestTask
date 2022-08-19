//
//  ScreenViewWithNavigationBar.swift
//  DoitSoftwareIosTestTaskPresentation
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import AUIKit

class ScreenViewWithNavigationBar: AUIStatusBarScreenView {

    // MARK: Elements

    let navigationBarView = UIView()

    // MARK: Setup

    override func setup() {
        super.setup()
        addSubview(navigationBarView)
        setupNavigationBarView()
    }

    func setupNavigationBarView() {

    }

    // MARK: Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutNavigationBarView()
    }

    func layoutNavigationBarView() {
        let x: CGFloat = 0
        let y: CGFloat = statusBarView.frame.origin.y + statusBarView.frame.size.height
        let width: CGFloat = bounds.size.width
        let height: CGFloat = 44
        let frame = CGRect(x: x, y: y, width: width, height: height)
        navigationBarView.frame = frame
    }

}
