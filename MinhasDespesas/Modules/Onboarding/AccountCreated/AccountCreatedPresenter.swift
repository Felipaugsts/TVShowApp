//
//  AccountCreatedPresenter.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 11/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit

// MARK: - AccountCreatedPresenter Protocol

protocol AccountCreatedPresenterProtocol: AnyObject {
    var controller: AccountCreatedViewControllerProtocol? { get set }
    
    func presentScreenValues()
}

// MARK: - AccountCreatedPresenter Implementation

class AccountCreatedPresenter: AccountCreatedPresenterProtocol {
    weak var controller: AccountCreatedViewControllerProtocol?

    // MARK: - Initializer
    
    init() { }
    
    // MARK: - Public Methods
    
    func presentScreenValues() {
        let values = AccountCreatedModel.ScreenValues(example: "example")
        controller?.displayScreenValues(values)
    }
}
