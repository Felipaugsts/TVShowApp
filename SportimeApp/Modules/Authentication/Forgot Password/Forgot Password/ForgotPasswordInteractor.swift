//
//  ForgotPasswordInteractor.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 11/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import SDKCommon
import UIKit

// MARK: - ForgotPasswordInteractor Protocol

protocol ForgotPasswordInteractorProtocol: AnyObject {
    var presenter: ForgotPasswordPresenterProtocol? { get set }
    
    func loadScreenValues()
    func sendNewPassword(email: String?)
}

// MARK: - ForgotPasswordInteractor Implementation

class ForgotPasswordInteractor: ForgotPasswordInteractorProtocol {
    weak var presenter: ForgotPasswordPresenterProtocol?
    
    private var service: AuthServiceLogic
    
    // MARK: - Initializer
    
    init(service: AuthServiceLogic = AuthService()) {
        self.service = service
    }
    
    // MARK: - Public Methods
    
    func loadScreenValues() {
        presenter?.presentScreenValues()
    }
    
    func sendNewPassword(email: String?) {
        guard let email = email else {
            return
        }
        
        service.sendPasswordResetEmail(email) { _, _ in
            self.presenter?.presentPasswordSent()
        }
    }
}
