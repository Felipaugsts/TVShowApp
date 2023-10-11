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
        textField.keyboardType = .numberPad
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
            self.startLoading()
            self.interactor.validate(password: self.textField.text)
        }
    }
}

// MARK: CreatePasswordViewControllerProtocol Implementation

extension CreatePasswordViewController: CreatePasswordViewControllerProtocol {
    
    func displayScreenValues(_ values: CreatePasswordModel.ScreenValues) {
        stopLoading()
        
        DispatchQueue.main.async {
            self.labelTitle.text = values.title
            self.textField.placeholder = values.placeholder
            self.confirmButton.setTitle(values.button, for: .normal)
            self.textField.text = ""
        }
    }
}
