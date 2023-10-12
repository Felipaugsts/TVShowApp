//
//  ForgotPasswordConfirmationInteractor.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 11/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit

// MARK: - ForgotPasswordConfirmationInteractor Protocol

protocol ForgotPasswordConfirmationInteractorProtocol: AnyObject {
    var presenter: ForgotPasswordConfirmationPresenterProtocol? { get set }
    
    func loadScreenValues()
}

// MARK: - ForgotPasswordConfirmationInteractor Implementation

class ForgotPasswordConfirmationInteractor: ForgotPasswordConfirmationInteractorProtocol {
    weak var presenter: ForgotPasswordConfirmationPresenterProtocol?

    // MARK: - Initializer
    
    init() { }
    
    // MARK: - Public Methods
    
    func loadScreenValues() {
        presenter?.presentScreenValues()
    }
}
