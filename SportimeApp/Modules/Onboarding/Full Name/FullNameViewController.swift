//
//  FullNameViewController.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 03/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit
import SDKCommon

// MARK: - IFullNameViewController

protocol FullNameViewControllerProtocol: AnyObject {
    func displayScreenValues(_ values: FullNameModel.ScreenValues)
    func displayEmail()
    func displayInvalidUsername()
}

// MARK: - FullNameViewController

class FullNameViewController: OnboardingLayoutController {
    var interactor: FullNameInteractorProtocol
    var presenter: FullNamePresenterProtocol
    var router: FullNameRouterProtocol
    
    init(interactor: FullNameInteractorProtocol = FullNameInteractor(),
         presenter: FullNamePresenterProtocol = FullNamePresenter(),
         router: FullNameRouterProtocol = FullNameRouter()) {
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
    
    private func setup() {
        interactor.presenter = presenter
        presenter.controller = self
        router.controller = self
    }
    
    private func addActions() {
        confirmButton.addAction {
            self.hideError()
            self.textField.resignFirstResponder()
            self.startLoading()
            self.interactor.validate(self.textField.text)
        }
    }
}

// MARK: FullNameViewControllerProtocol Implementation

extension FullNameViewController: FullNameViewControllerProtocol {
    
    func displayScreenValues(_ values: FullNameModel.ScreenValues) {
        labelTitle.text = values.title
        textField.placeholder = values.placeholder
        confirmButton.setButtonTitle(title: values.button)
    }
    
    func displayEmail() {
        router.routeToEmail(textField.text)
    }
    
    func displayInvalidUsername() {
        stopLoading()
        setError(text: "Nome inválido.")
    }
}
