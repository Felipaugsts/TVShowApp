//
//  ForgotPasswordConfirmationPresenter.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 11/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit

// MARK: - ForgotPasswordConfirmationPresenter Protocol

protocol ForgotPasswordConfirmationPresenterProtocol: AnyObject {
    var controller: ForgotPasswordConfirmationViewControllerProtocol? { get set }
    
    func presentScreenValues()
}

// MARK: - ForgotPasswordConfirmationPresenter Implementation

class ForgotPasswordConfirmationPresenter: ForgotPasswordConfirmationPresenterProtocol {
    weak var controller: ForgotPasswordConfirmationViewControllerProtocol?

    // MARK: - Initializer
    
    init() { }
    
    // MARK: - Public Methods
    
    func presentScreenValues() {
        let values = ForgotPasswordConfirmationModel.ScreenValues(example: "example")
        controller?.displayScreenValues(values)
    }
}
