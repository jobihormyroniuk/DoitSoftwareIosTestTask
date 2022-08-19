//
//  SignInSignUpScreenController.swift
//  DoitSoftwareIosTestTaskPresentation
//
//  Created by Ihor Myroniuk on 26.12.2020.
//

import AUIKit
import AFoundation

protocol SignInSignUpScreenControllerDelegate: class {
    func signInSignUpScreenControllerSignIn(_ signInSignUpScreenController: SignInSignUpScreenController, data: SignInData)
    func signInSignUpScreenControllerSignUp(_ signInSignUpScreenController: SignInSignUpScreenController, data: SignInData)
}

class SignInSignUpScreenController: UIViewController {
    // MARK: Delegate

    weak var delegate: SignInSignUpScreenControllerDelegate?
    
    // MARK: SignInSignUpScreenView
    
    override func loadView() {
        view = SignInSignUpScreenView()
    }
    
    var signInSignUpScreenView: SignInSignUpScreenView! {
        return view as? SignInSignUpScreenView
    }
    
    // MARK: Localization

    private let localizer: Localizer = {
        let bundle = Bundle(for: SignInSignUpScreenController.self)
        let tableName = "SignInSignUpScreenStrings"
        let textLocalizer = TableNameBundleTextLocalizer(tableName: tableName, bundle: bundle)
        let localizator = CompositeLocalizer(textLocalization: textLocalizer)
        return localizator
    }()
    
    private let tapGestureRecognizer = UITapGestureRecognizer()
    
    // MARK: Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInSignUpScreenView.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.addTarget(self, action: #selector(tapGestureRecognizerAction))
        signInSignUpScreenView.emailTextField.autocapitalizationType = .none
        signInSignUpScreenView.passwordTextField.autocapitalizationType = .none
        signInSignUpScreenView.passwordTextField.isSecureTextEntry = true
        signInSignUpScreenView.signInSignUpSwitch.addTarget(self, action: #selector(signInSignUpSwitchValueChanged), for: .valueChanged)
        signInSignUpScreenView.signInSignUpButton.addTarget(self, action: #selector(signInSignUpButtonTouchUpInside), for: .touchUpInside)
        switchSignIn()
        isSignUp = false
        signInSignUpScreenView.signInSignUpSwitch.isOn = false
        setContent()
        setContentSignIn()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object:nil)
    }
    
    @objc private func keyboardWillChangeFrame(notification: NSNotification) {
        guard let height = ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]) as? NSValue)?.cgRectValue.origin.y else { return }
        view.frame.size.height = height
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    @objc private func tapGestureRecognizerAction() {
        view.endEditing(true)
    }
    
    // MARK: Events
    
    @objc private func signInSignUpSwitchValueChanged() {
        if signInSignUpScreenView.signInSignUpSwitch.isOn {
            switchSignUp()
        } else {
            switchSignIn()
        }
    }
    
    @objc private func signInSignUpButtonTouchUpInside() {
        signInSignUp()
    }
    
    // MARK: Actions
    
    private var isSignUp: Bool = false
    
    private func switchSignIn() {
        isSignUp = false
        setContentSignIn()
        signInSignUpScreenView.setNeedsLayout()
        signInSignUpScreenView.layoutIfNeeded()
    }
    
    private func switchSignUp() {
        isSignUp = true
        setContentSignUp()
        signInSignUpScreenView.setNeedsLayout()
        signInSignUpScreenView.layoutIfNeeded()
    }
    
    private func signInSignUp() {
        let email = signInSignUpScreenView.emailTextField.text ?? ""
        let password = signInSignUpScreenView.passwordTextField.text ?? ""
        if isSignUp {
            let data = SignInData(email: email, password: password)
            delegate?.signInSignUpScreenControllerSignUp(self, data: data)
        } else {
            let data = SignInData(email: email, password: password)
            delegate?.signInSignUpScreenControllerSignIn(self, data: data)
        }
    }
    
    // MARK: SetContent
    
    private func setContent() {
        signInSignUpScreenView.signInSignUpSwitchTitleLabel.text = localizer.localizeText("signInSignUpSwitchTitle")
        signInSignUpScreenView.emailTextField.placeholder = localizer.localizeText("emailTextInputPlaceholder")
        signInSignUpScreenView.passwordTextField.placeholder = localizer.localizeText("passwordTextInputPlaceholder")
    }
    
    private func setContentSignIn() {
        signInSignUpScreenView.titleLabel.text = localizer.localizeText("signInTitle")
        signInSignUpScreenView.signInSignUpButton.setTitle(localizer.localizeText("signInButtonTitle"), for: .normal)
    }
    
    private func setContentSignUp() {
        signInSignUpScreenView.titleLabel.text = localizer.localizeText("signUpTitle")
        signInSignUpScreenView.signInSignUpButton.setTitle(localizer.localizeText("signUpButtonTitle"), for: .normal)
    }
}
