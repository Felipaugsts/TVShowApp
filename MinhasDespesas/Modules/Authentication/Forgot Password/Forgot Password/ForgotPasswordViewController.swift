//
//  ForgotPasswordViewController.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 11/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit

// MARK: - IForgotPasswordViewController

protocol ForgotPasswordViewControllerProtocol: AnyObject {
    func displayScreenValues(_ values: ForgotPasswordModel.ScreenValues)
    func displayPasswordSent()
}

// MARK: - ForgotPasswordViewController

class ForgotPasswordViewController: OnboardingLayoutController {
    
    var interactor: ForgotPasswordInteractorProtocol
    var presenter: ForgotPasswordPresenterProtocol
    var router: ForgotPasswordRouterProtocol
    
    init(interactor: ForgotPasswordInteractorProtocol = ForgotPasswordInteractor(),
         presenter: ForgotPasswordPresenterProtocol = ForgotPasswordPresenter(),
         router: ForgotPasswordRouterProtocol = ForgotPasswordRouter()) {
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        textField.resignFirstResponder()
    }
    
    private func setup() {
        interactor.presenter = presenter
        presenter.controller = self
        router.controller = self
    }
    
    private func addActions() {
        confirmButton.addAction {
            self.startLoading()
            self.interactor.sendNewPassword(email: self.textField.text)
        }
    }
}

// MARK: ForgotPasswordViewControllerProtocol Implementation

extension ForgotPasswordViewController: ForgotPasswordViewControllerProtocol {
    
    func displayScreenValues(_ values: ForgotPasswordModel.ScreenValues) {
        self.labelTitle.text = "Digite seu email"
        self.labelSubtitle.text = "Enviaremos um link no seu email."
        self.textField.placeholder = "Email"
        self.confirmButton.setButtonTitle(title: "Confirmar")
        self.textField.text = ""
    }
    
    func displayPasswordSent() {
        router.routePasswordSent()
    }
}
