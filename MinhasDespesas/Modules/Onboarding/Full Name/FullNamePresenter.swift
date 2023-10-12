//
//  FullNamePresenter.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 03/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit

// MARK: - FullNamePresenter Protocol

protocol FullNamePresenterProtocol: AnyObject {
    var controller: FullNameViewControllerProtocol? { get set }
    
    func presentScreenValues()
    func presentEmail()
    func presentInvalidUsername()
}

// MARK: - FullNamePresenter Implementation

class FullNamePresenter: FullNamePresenterProtocol {
    weak var controller: FullNameViewControllerProtocol?

    // MARK: - Initializer
    
    init() { }
    
    // MARK: - Public Methods
    
    func presentScreenValues() {
        let values = FullNameModel.ScreenValues(title: "Qual o seu\nnome completo?",
                                                placeholder: "Nome completo",
                                                button: "Continuar")
        controller?.displayScreenValues(values)
    }
    
    func presentEmail() {
        controller?.displayEmail()
    }
    
    func presentInvalidUsername() {
        controller?.displayInvalidUsername()
    }
}
