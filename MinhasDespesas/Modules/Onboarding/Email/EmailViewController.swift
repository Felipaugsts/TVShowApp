//
//  EmailViewController.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 03/10/23.
// 

import UIKit

// MARK: - IEmailViewController

protocol EmailViewControllerProtocol: AnyObject {
    func displayScreenValues(_ values: EmailModel.ScreenValues)
    func displayCreatePassword()
    func displayInvalidEmail()
}

// MARK: - EmailViewController

class EmailViewController: OnboardingLayoutController {
    
    var interactor: (EmailInteractorProtocol & EmailDataStore)
    var presenter: EmailPresenterProtocol
    var router: (NSObjectProtocol & EmailRouterProtocol & EmailDataPassing)
    
    init(interactor: (EmailInteractorProtocol & EmailDataStore) = EmailInteractor(),
         presenter: EmailPresenterProtocol = EmailPresenter(),
         router: (NSObjectProtocol & EmailRouterProtocol & EmailDataPassing) = EmailRouter()) {
        self.interactor = interactor
        self.presenter = presenter
        self.router = router
        
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadScreenValues()
        addActions()
        textField.keyboardType = .emailAddress
    }
    
    private func setup() {
        interactor.presenter = presenter
        presenter.controller = self
        router.controller = self
        router.dataStore = interactor
    }
    
    private func addActions() {
        confirmButton.addAction {
            self.startLoading()
            self.interactor.validate(self.textField.text)
        }
        
        textField.addTarget(self, action: #selector(disableError), for: .editingChanged)
    }
    
    @objc func disableError() {
        if !errorLabel.isHidden {
           hideError()
        }
    }
}

// MARK: EmailViewControllerProtocol Implementation

extension EmailViewController: EmailViewControllerProtocol {
    
    func displayScreenValues(_ values: EmailModel.ScreenValues) {
        labelTitle.text = values.title
        textField.placeholder = values.placeholder
        confirmButton.setButtonTitle(title: values.button)
    }
    
    func displayCreatePassword() {
        router.routeToCreatePassword()
    }
    
    func displayInvalidEmail() {
        stopLoading()
        setError(text: "Email inválido.")
    }
}
