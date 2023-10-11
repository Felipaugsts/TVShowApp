//
//  LoginViewController.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 10/07/23.
//

import UIKit
import SDKCommon

// MARK: - Protocol

public protocol LoginViewControllerLogic {
    func displayHomeScreen()
    func displayWrongPassword()
    func displayScreenValues(_ values: LoginModel.ScreenValues)
}

class LoginViewController: UIViewController, LoginViewControllerLogic {

    // MARK: - Components
    
    var textField: UITextField = {
        let textField = UITextField()
        textField.tintColor = .darkGray
        textField.textColor = .darkGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var textfieldUnderline: UIView = {
        let underline = UIView()
        underline.translatesAutoresizingMaskIntoConstraints = false
        underline.backgroundColor = .darkGray
        return underline
    }()
    
    var passwordField: UITextField = {
        let textField = UITextField()
        textField.tintColor = .darkGray
        textField.textColor = .darkGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        return textField
    }()

    var passwordUnderline: UIView = {
        let underline = UIView()
        underline.translatesAutoresizingMaskIntoConstraints = false
        underline.backgroundColor = .darkGray
        return underline
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()

    lazy var signInButton: Button = {
       let button = Button()
        button.tintColor = DSColor.lightest
        button.backgroundColor = DSColor.primaryDark
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(confirmButton), for: .touchUpInside)
        return button
    }()
    
    lazy var forgotPasswordButton: Button = {
       let button = Button()
        button.tintColor = DSColor.lightest
        button.backgroundColor = DSColor.primaryDark
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Private Variables
    
    private var interactor: LoginInteractorLogic
    private var presenter: LoginPresenterLogic
    private var router: LoginRouterLogic
    
    private lazy var confirmTrailing = signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
    private lazy var confirmLeading = signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
    private lazy var confirmBottom = signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
    
    // MARK: - View Lifecycle
    
    public init(interactor: LoginInteractorLogic = LoginInteractor(),
                presenter: LoginPresenterLogic = LoginPresenter(),
                router: LoginRouterLogic = LoginRouter()) {
        self.interactor = interactor
        self.presenter = presenter
        self.router = router
        
        
        super.init(nibName: nil, bundle: nil)
        
        setupArch()
    }
    
    public required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        stopLoading()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        interactor.loadValues()
        setupLayout()
        dismissKeyboardOnTap()
        listenKeyboardChange()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardListener()
    }
    
    // MARK: - Private Methods
    
    private func setupArch() {
        interactor.presenter = presenter
        presenter.controller = self
        router.controller = self
    }
    
    @objc
    private func confirmButton() {
        guard let email = textField.text,
              let password = passwordField.text,
              !email.isEmpty,
              !password.isEmpty else { return }
        startLoading()
        interactor.authenticate(email: email, password: password)
    }
    
    private func startLoading() {
        signInButton.startLoading()
        view.inputViewController?.isEditing = false
        view.isUserInteractionEnabled = false
    }
    
    private func stopLoading() {
        signInButton.stopLoading()
        view.isUserInteractionEnabled = true
    }
    
    @objc
    private func forgotPassword() {
        interactor.tapForgotPassword()
    }
    
    public func displayHomeScreen() {
        router.routeToHome()
    }
    
    public func displayWrongPassword() {
        stopLoading()
        passwordUnderline.backgroundColor = DSColor.negative
    }
    
    func displayScreenValues(_ values: LoginModel.ScreenValues) {
        label.text = values.title
        
        // TextField
        signInButton.setTitle("Entrar", for: .normal)
        textField.attributedPlaceholder = NSAttributedString(string: values.textFieldText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        passwordField.attributedPlaceholder = NSAttributedString(string: values.passwordText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        // Buttons
        signInButton.setButtonTitle(title: values.confirmButton)
        forgotPasswordButton.setButtonTitle(title: values.forgotPassword)
        
    }
}

// MARK: - Extension

extension LoginViewController {
    
    private func listenKeyboardChange() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardListener() {
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }
    
    @objc
     private func keyboardWillAppear(_ notification: NSNotification) {
         moveViewWithKeyboard(notification: notification,  keyboardWillShow: true)
     }
     
     @objc
     private func keyboardWillDisappear(_ notification: NSNotification) {
         moveViewWithKeyboard(notification: notification, keyboardWillShow: false)
     }
    
    // MARK: - Layout
    
    func setupLayout() {
        view.backgroundColor = DSColor.lightest
        
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(textfieldUnderline)
        
        view.addSubview(passwordField)
        view.addSubview(passwordUnderline)
        
        view.addSubview(signInButton)
        view.addSubview(forgotPasswordButton)
        
        NSLayoutConstraint.activate( [
            // Text
            label.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 170),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            // Username
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 130),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            textfieldUnderline.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            textfieldUnderline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textfieldUnderline.heightAnchor.constraint(equalToConstant: 1),
            textfieldUnderline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            // Password
            passwordField.topAnchor.constraint(equalTo: textfieldUnderline.bottomAnchor, constant: 50),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            passwordUnderline.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            passwordUnderline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordUnderline.heightAnchor.constraint(equalToConstant: 1),
            passwordUnderline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            // Login Button
            signInButton.topAnchor.constraint(equalTo: passwordUnderline.bottomAnchor, constant: 50),
            signInButton.heightAnchor.constraint(equalToConstant: 55),
            confirmTrailing,
            confirmLeading,
            
            // Forgot Password
            forgotPasswordButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 30),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 55),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        ])
    }
    
    // MARK: - Keyboard Change
    
    @objc
    private func moveViewWithKeyboard(notification: NSNotification, keyboardWillShow: Bool) {
        
        // Get keyboard's size
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardSize.height
        
        // Keyboard's animation duration
        let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.0
        
        // Keyboard's animation curve
        let rawValue = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int ?? 0
        let keyboardCurve = UIView.AnimationCurve(rawValue: rawValue)
        
        // Change the constraints
        forgotPasswordButton.isHidden = keyboardWillShow
        
        if keyboardWillShow {
            confirmBottom.constant = -keyboardHeight
            confirmBottom.isActive = true
            confirmTrailing.constant = 0
            confirmLeading.constant = 0
            signInButton.layer.cornerRadius = 0
        } else {
            confirmBottom.isActive = false
            confirmTrailing.constant = -40
            confirmLeading.constant = 40
            signInButton.layer.cornerRadius = 16
        }
        
        animateIfNeeded(duration: keyboardDuration, curve: keyboardCurve)
    }
    
    private func animateIfNeeded(duration: TimeInterval, curve: UIView.AnimationCurve?) {
         guard let curve else {
             view.layoutIfNeeded()
             return
         }
         let animator = UIViewPropertyAnimator(duration: duration, curve: curve) { [weak self] in
             self?.view.layoutIfNeeded()
         }
         animator.startAnimation()
     }
}
