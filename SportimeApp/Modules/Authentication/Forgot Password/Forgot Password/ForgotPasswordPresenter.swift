//
//  ForgotPasswordPresenter.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 11/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit

// MARK: - ForgotPasswordPresenter Protocol

protocol ForgotPasswordPresenterProtocol: AnyObject {
    var controller: ForgotPasswordViewControllerProtocol? { get set }
    
    func presentScreenValues()
    func presentPasswordSent()
}

// MARK: - ForgotPasswordPresenter Implementation

class ForgotPasswordPresenter: ForgotPasswordPresenterProtocol {
    weak var controller: ForgotPasswordViewControllerProtocol?

    // MARK: - Initializer
    
    init() { }
    
    // MARK: - Public Methods
    
    func presentScreenValues() {
        let values = ForgotPasswordModel.ScreenValues(example: "example")
        controller?.displayScreenValues(values)
    }
    
    func presentPasswordSent() {
        controller?.displayPasswordSent()
    }
}
