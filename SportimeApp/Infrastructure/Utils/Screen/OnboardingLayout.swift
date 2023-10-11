//
//  OnboardingLayout.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 03/10/23.
//

import SDKCommon
import UIKit

class OnboardingLayoutController: UIViewController {
    
    var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    var textField: UITextField = {
        let textField = UITextField()
        textField.tintColor = .darkGray
        textField.textColor = .darkGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.resignFirstResponder()
    
        // Change font and size for the text field
        textField.font = UIFont(name: "Helvetica-Bold", size: 20.0) // Change the font and size as needed
        
        // Change placeholder text size
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Helvetica-Bold", size: 20.0) ?? UIFont.systemFont(ofSize: 17.0), // Change the placeholder font and size as needed
            .foregroundColor: UIColor.lightGray // Change the placeholder text color if desired
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Nome completo", attributes: attributes)
        return textField
    }()
    
    var textfieldUnderline: UIView = {
        let underline = UIView()
        underline.translatesAutoresizingMaskIntoConstraints = false
        underline.backgroundColor = .black
        return underline
    }()
    
    lazy var confirmButton: Button = {
       let button = Button()
        button.tintColor = DSColor.lightest
        button.backgroundColor = DSColor.primary
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.textField.becomeFirstResponder()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupViewLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        PanNotifications.shared.removeAllObservers()
    }
    
    func setupLayout() {
        view.backgroundColor = DSColor.light
        setupContrainst()
    }

    lazy var confirmBottom = confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
    lazy var confirmRight = confirmButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
    lazy var confirmLeft = confirmButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32)
    
    private func setupContrainst() {
        view.addSubview(labelTitle)
        view.addSubview(textField)
        view.addSubview(textfieldUnderline)
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Password
            textField.topAnchor.constraint(lessThanOrEqualTo: labelTitle.bottomAnchor, constant: 80),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            textfieldUnderline.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            textfieldUnderline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textfieldUnderline.heightAnchor.constraint(equalToConstant: 1),
            textfieldUnderline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            confirmButton.heightAnchor.constraint(equalToConstant: 55),
            confirmBottom,
            confirmRight,
            confirmLeft
        ])
        
        view.layoutIfNeeded()
    }
    
    public func startLoading() {
        textField.resignFirstResponder()
        view.isUserInteractionEnabled = false
        confirmButton.startLoading()
    }
    
    public func stopLoading() {
        view.isUserInteractionEnabled = true
        confirmButton.stopLoading()
    }
    
    private func setupViewLayout() {
        listenKeyBoardChangeWith(
            PanNotifications.shared,
            keyboardWillAppear: #selector(keyboardWillShow(_:)),
            keyboardWillDisappear: #selector(keyboardWillHide(_:))
        )
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        // Handle keyboard appearance
        moveViewWithKeyboard(notification: notification, keyboardWillShow: true)
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        // Handle keyboard disappearance
        moveViewWithKeyboard(notification: notification, keyboardWillShow: false)
    }
}

extension OnboardingLayoutController: ListenKeyboardChanges {
    func customizeViewWhenKeyboardAppear(keyboardHeight: CGFloat) {
        confirmBottom.constant = -keyboardHeight
        confirmBottom.isActive = true
        confirmRight.constant = 0
        confirmLeft.constant = 0
        confirmButton.layer.cornerRadius = 0
    }
    
    func customizeViewWhenKeyboardDisappear() {
        confirmRight.constant = -32
        confirmLeft.constant = 32
        confirmBottom.constant = -40
        confirmButton.layer.cornerRadius = 16
    }
}
