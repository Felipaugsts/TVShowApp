//
//  ForgotPasswordRouter.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 11/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit

// MARK: - ForgotPasswordRouter Protocol

protocol ForgotPasswordRouterProtocol: AnyObject {
    var controller: UIViewController? { get set }
    
    func routePasswordSent()
}

// MARK: - ForgotPasswordRouter Implementation

class ForgotPasswordRouter: ForgotPasswordRouterProtocol {
    weak var controller: UIViewController?

    // MARK: - Initializer
    
    init() { }
    
    func routePasswordSent() {
        let destination = ForgotPasswordConfirmationViewController()
        controller?.navigationController?.pushViewController(destination, animated: true)
    }
}
