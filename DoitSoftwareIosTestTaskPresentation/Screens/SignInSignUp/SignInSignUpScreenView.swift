//
//  SignInSignUpScreenView.swift
//  DoitSoftwareIosTestTaskPresentation
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import AUIKit

class SignInSignUpScreenView: AUIStatusBarScreenView {
    // MARK: Subviews
    
    let scrollView = UIScrollView()
    let titleLabel = UILabel()
    let emailTextField: UITextField = SignInSignUpScreenTextField()
    let passwordTextField: UITextField = SignInSignUpScreenTextField()
    let signInSignUpSwitchTitleLabel = UILabel()
    let signInSignUpSwitch = UISwitch()
    let signInSignUpButton: UIButton = SignInSignUpScreenButton()

    // MARK: Setup

    override func setup() {
        super.setup()
        backgroundColor = .lightGray
        addSubview(scrollView)
        setupScrollView()
    }

    override func setupStatusBarView() {
        super.setupStatusBarView()
        statusBarView.backgroundColor = .gray
    }

    private func setupScrollView() {
        scrollView.alwaysBounceVertical = true
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(signInSignUpSwitchTitleLabel)
        scrollView.addSubview(signInSignUpSwitch)
        scrollView.addSubview(signInSignUpButton)
    }

    // MARK: Layout
    
    private let rightPadding: CGFloat = 32
    private let leftPadding: CGFloat = 32

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutScrollView()
        layoutTitleLabel()
        layouteEmailTextField()
        layoutePasswordTextField()
        layoutSignInSignUpSwitch()
        layoutSignInSignUpSwitchTitleLabel()
        layoutSignInSignUpButton()
        setScrollViewContentSize()
    }

    private func layoutScrollView() {
        let x: CGFloat = 0
        let y = statusBarView.frame.origin.y + statusBarView.frame.height
        let width = bounds.size.width
        let height = bounds.height - y
        let frame = CGRect(x: x, y: y, width: width, height: height)
        scrollView.frame = frame
    }
    
    private func layoutTitleLabel() {
        let availableWidth = bounds.width - rightPadding - leftPadding
        let availableHeight = CGFloat.greatestFiniteMagnitude
        let availableSize = CGSize(width: availableWidth, height: availableHeight)
        let size = titleLabel.sizeThatFits(availableSize)
        let x = (bounds.width - size.width) / 2
        let y: CGFloat = 32
        let origin = CGPoint(x: x, y: y)
        let frame = CGRect(origin: origin, size: size)
        titleLabel.frame = frame
    }
    
    private func layouteEmailTextField() {
        let x = leftPadding
        let y = titleLabel.frame.origin.y + titleLabel.frame.size.height + 32
        let width = bounds.width - rightPadding - leftPadding
        let height: CGFloat = 64
        let frame = CGRect(x: x, y: y, width: width, height: height)
        emailTextField.frame = frame
    }
    
    private func layoutePasswordTextField() {
        let x = leftPadding
        let y = emailTextField.frame.origin.y + emailTextField.frame.size.height + 32
        let width = bounds.width - rightPadding - leftPadding
        let height: CGFloat = 64
        let frame = CGRect(x: x, y: y, width: width, height: height)
        passwordTextField.frame = frame
    }
    
    private func layoutSignInSignUpSwitch() {
        let availableWidth = bounds.width - rightPadding - leftPadding
        let availableHeight = CGFloat.greatestFiniteMagnitude
        let availableSize = CGSize(width: availableWidth, height: availableHeight)
        let size = signInSignUpSwitch.sizeThatFits(availableSize)
        let x = bounds.width - rightPadding - size.width
        let y = passwordTextField.frame.origin.y + passwordTextField.frame.size.height + 32
        let origin = CGPoint(x: x, y: y)
        let frame = CGRect(origin: origin, size: size)
        signInSignUpSwitch.frame = frame
    }
    
    private func layoutSignInSignUpSwitchTitleLabel() {
        let availableWidth = bounds.width - rightPadding - signInSignUpSwitch.bounds.width - leftPadding
        let availableHeight = CGFloat.greatestFiniteMagnitude
        let availableSize = CGSize(width: availableWidth, height: availableHeight)
        let size = signInSignUpSwitchTitleLabel.sizeThatFits(availableSize)
        let x = rightPadding
        let y: CGFloat = signInSignUpSwitch.frame.origin.y + (signInSignUpSwitch.bounds.height - size.height) / 2
        let origin = CGPoint(x: x, y: y)
        let frame = CGRect(origin: origin, size: size)
        signInSignUpSwitchTitleLabel.frame = frame
    }
    
    private func layoutSignInSignUpButton() {
        let x = leftPadding
        let y = signInSignUpSwitch.frame.origin.y + signInSignUpSwitch.frame.size.height + 32
        let width = bounds.width - rightPadding - leftPadding
        let height: CGFloat = 64
        let frame = CGRect(x: x, y: y, width: width, height: height)
        signInSignUpButton.frame = frame
    }
    
    private func setScrollViewContentSize() {
        let width = scrollView.frame.size.width
        let height = signInSignUpButton.frame.origin.y + signInSignUpButton.frame.height + 32
        let size = CGSize(width: width, height: height)
        scrollView.contentSize = size
    }
}

private class SignInSignUpScreenTextField: AUITextField {
    override func setup() {
        super.setup()
        backgroundColor = .white
        layer.cornerRadius = 2
        layer.masksToBounds = true
        layer.borderWidth = 2
        layer.borderColor = UIColor.gray.cgColor
        tintColor = .gray
    }
}

private class SignInSignUpScreenButton: AUIButton {
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
}
