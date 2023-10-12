//
//  EmailPresenter.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 03/10/23.
//  

import UIKit

// MARK: - EmailPresenter Protocol

protocol EmailPresenterProtocol: AnyObject {
    var controller: EmailViewControllerProtocol? { get set }
    
    func presentScreenValues()
    func presentCreatePassword()
    func presentInvalidEmail()
}

// MARK: - EmailPresenter Implementation

class EmailPresenter: EmailPresenterProtocol {
    weak var controller: EmailViewControllerProtocol?
    
    // MARK: - Initializer
    
    init() { }
    
    // MARK: - Public Methods
    
    func presentScreenValues() {
        let values = EmailModel.ScreenValues(title: "Qual o seu\nemail?",
                                             placeholder: "example@gmail.com",
                                             button: "Continuar")
        controller?.displayScreenValues(values)
    }
    
    func presentCreatePassword() {
        controller?.displayCreatePassword()
    }
    
    func presentInvalidEmail() {
        controller?.displayInvalidEmail()
    }
}
