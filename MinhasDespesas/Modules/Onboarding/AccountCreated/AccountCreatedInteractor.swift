//
//  AccountCreatedInteractor.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 11/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit

// MARK: - AccountCreatedInteractor Protocol

protocol AccountCreatedInteractorProtocol: AnyObject {
    var presenter: AccountCreatedPresenterProtocol? { get set }
    
    func loadScreenValues()
}

// MARK: - AccountCreatedInteractor Implementation

class AccountCreatedInteractor: AccountCreatedInteractorProtocol {
    weak var presenter: AccountCreatedPresenterProtocol?

    // MARK: - Initializer
    
    init() { }
    
    // MARK: - Public Methods
    
    func loadScreenValues() {
        presenter?.presentScreenValues()
    }
}
