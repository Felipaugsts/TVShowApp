//
//  CreatePasswordPresenter.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 10/10/23.
//  

import UIKit

// MARK: - CreatePasswordPresenter Protocol

protocol CreatePasswordPresenterProtocol: AnyObject {
    var controller: CreatePasswordViewControllerProtocol? { get set }
    
    func presentScreenValues()
    func presentInvalidPassword()
    func presentConfirmPassword()
    func presentAccountCreated()
}

// MARK: - CreatePasswordPresenter Implementation

class CreatePasswordPresenter: CreatePasswordPresenterProtocol {
    weak var controller: CreatePasswordViewControllerProtocol?
    
    // MARK: - Initializer
    
    init() { }
    
    // MARK: - Public Methods
    
    func presentScreenValues() {
        let values = CreatePasswordModel.ScreenValues(title: "Crie uma\nsenha",
                                                      placeholder: "Senha",
                                                      button: "Confirmar")
        controller?.displayScreenValues(values)
    }
    
    func presentInvalidPassword() {
        let values = CreatePasswordModel.ScreenValues(title: "Crie uma\nsenha",
                                                      placeholder: "Senha",
                                                      button: "Confirmar")
        controller?.displayScreenValues(values)
        controller?.displayInvalidPassword()
    }
    
    func presentConfirmPassword() {
        let values = CreatePasswordModel.ScreenValues(title: "Confirme sua nova\nsenha",
                                                      placeholder: "Confirmar senha", button: "Confirmar")
        controller?.displayScreenValues(values)
    }
    
    func presentAccountCreated() {
        controller?.displayAccountCreated()
    }
}
