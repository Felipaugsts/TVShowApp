//
//  AccountCreatedRouter.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 11/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit

// MARK: - AccountCreatedRouter Protocol

protocol AccountCreatedRouterProtocol: AnyObject {
    var controller: UIViewController? { get set }
    
    func routeToLogin()
}

// MARK: - AccountCreatedRouter Implementation

class AccountCreatedRouter: AccountCreatedRouterProtocol {
    weak var controller: UIViewController?

    // MARK: - Initializer
    
    init() { }
    
    func routeToLogin() {
        UIApplication.setRootViewControllerWithNavigation(LoginViewController())
    }
}
