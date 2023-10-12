//
//  CreatePasswordViewController.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 10/10/23.
// 

import UIKit

// MARK: - ICreatePasswordViewController

protocol CreatePasswordViewControllerProtocol: AnyObject {
    func displayScreenValues(_ values: CreatePasswordModel.ScreenValues)
    func displayAccountCreated()
    func displayInvalidPassword()
}

// MARK: - CreatePasswordViewController

class CreatePasswordViewController: OnboardingLayoutController {
    
    var interactor: (CreatePasswordInteractorProtocol & CreatePasswordDataStore)
    var presenter: CreatePasswordPresenterProtocol
    var router: ( NSObjectProtocol & CreatePasswordRouterProtocol & CreatePasswordRouterDataPassing )
    
    init(interactor: (CreatePasswordInteractorProtocol & CreatePasswordDataStore) = CreatePasswordInteractor(),
         presenter: CreatePasswordPresenterProtocol = CreatePasswordPresenter(),
         router: ( NSObjectProtocol & CreatePasswordRouterProtocol & CreatePasswordRouterDataPassing ) = CreatePasswordRouter()) {
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
        textField.isSecureTextEntry = true
        textField.keyboardType = .default
        interactor.loadScreenValues()
        addActions()
    }
    
    private func setup() {
        interactor.presenter = presenter
        presenter.controller = self
        router.controller = self
        router.dataStore = interactor
    }
    
    private func addActions() {
        confirmButton.addAction {
            self.navigationController?.navigationBar.isUserInteractionEnabled = false
            self.startLoading()
            self.interactor.validate(password: self.textField.text)
        }
        
        textField.addTarget(self, action: #selector(disableError), for: .editingChanged)
    }
    
    @objc
    func disableError() {
        if !errorLabel.isHidden {
           hideError()
        }
    }
}

// MARK: CreatePasswordViewControllerProtocol Implementation

extension CreatePasswordViewController: CreatePasswordViewControllerProtocol {
    
    func displayScreenValues(_ values: CreatePasswordModel.ScreenValues) {
        stopLoading()
        displayKeyboard(time: 0.7)
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.isUserInteractionEnabled = true
            self.labelTitle.text = values.title
            self.textField.placeholder = values.placeholder
            self.confirmButton.setButtonTitle(title: values.button)
            self.textField.text = ""
        }
    }
    
    func displayAccountCreated() {
        router.routeToAccountCreated()
    }
    
    func displayInvalidPassword() {
        textField.text = ""
        setError(text: "Senha inválida.")
    }
}
