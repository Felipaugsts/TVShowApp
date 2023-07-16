//
//  LoginViewController.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 10/07/23.
//

import UIKit

public protocol LoginViewControllerLogic {
    func displayHomeScreen()
}

class LoginViewController: UIViewController, LoginViewControllerLogic {

    var textField: UITextField = {
        let textField = UITextField()
        textField.tintColor = .darkGray
        textField.textColor = .darkGray
        textField.attributedPlaceholder = NSAttributedString(string: "CPF", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var passwordField: UITextField = {
        let textField = UITextField()
        textField.tintColor = .darkGray
        textField.textColor = .darkGray
        textField.attributedPlaceholder = NSAttributedString(string: "Senha", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
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
        label.text = "Welcome \nBack"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    var textfieldUnderline: UIView = {
        let underline = UIView()
        underline.translatesAutoresizingMaskIntoConstraints = false
        underline.backgroundColor = .darkGray
        return underline
    }()

    lazy var signInButton: Button = {
       let button = Button()
        button.tintColor = .blue
        button.backgroundColor = DSColor.primaryDark
        button.layer.cornerRadius = 16
        button.setTitle("Entrar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(confirmButton), for: .touchUpInside)
        return button
    }()
    
    lazy var forgotPasswordButton: UIButton = {
       let button = UIButton()
        button.tintColor = .blue
        button.backgroundColor = DSColor.primaryDark
        button.layer.cornerRadius = 16
        button.setTitle("Esqueci minha senha", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
        return button
    }()
    
    lazy var confirmTrailing = signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
    lazy var confirmLeading = signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
    lazy var confirmBottom = signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
    
    var interactor: LoginInteractorLogic
    var presenter: LoginPresenterLogic
    var router: LoginRouterLogic
    
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
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        stopLoading()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setupLayout()
        dismissKeyboardOnTap()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupArch() {
        interactor.presenter = presenter
        presenter.controller = self
        router.controller = self
    }
    
    @objc
    private func confirmButton() {
        guard let email = textField.text,
        let password = passwordField.text else { return }
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
}

extension LoginViewController {
    
    @objc
     private func keyboardWillAppear(_ notification: NSNotification) {
         moveViewWithKeyboard(notification: notification,  keyboardWillShow: true)
     }
     
     @objc
     private func keyboardWillDisappear(_ notification: NSNotification) {
         moveViewWithKeyboard(notification: notification, keyboardWillShow: false)
     }
    
    func setupLayout() {
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(textfieldUnderline)
        
        view.addSubview(passwordField)
        view.addSubview(passwordUnderline)
        
        view.addSubview(signInButton)
        view.addSubview(forgotPasswordButton)
        
        NSLayoutConstraint.activate( [
            label.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 170),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 130),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            textfieldUnderline.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            textfieldUnderline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textfieldUnderline.heightAnchor.constraint(equalToConstant: 1),
            textfieldUnderline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            passwordField.topAnchor.constraint(equalTo: textfieldUnderline.bottomAnchor, constant: 50),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            passwordUnderline.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            passwordUnderline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordUnderline.heightAnchor.constraint(equalToConstant: 1),
            passwordUnderline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            signInButton.topAnchor.constraint(equalTo: passwordUnderline.bottomAnchor, constant: 50),
            signInButton.heightAnchor.constraint(equalToConstant: 55),
            confirmTrailing,
            confirmLeading,
            
            forgotPasswordButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 30),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 55),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        ])
    }
    
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

extension UIViewController {
    func dismissKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func dismissKeyboard(sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: view)
        
        // Check if the tap location is inside any of the text fields or buttons
        let tappedView = view.hitTest(tapLocation, with: nil)
        if !(tappedView is UITextField) && !(tappedView is UIButton) {
            view.endEditing(true)
        }
    }
}
