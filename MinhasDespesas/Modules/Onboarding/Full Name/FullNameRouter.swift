//
//  FullNameRouter.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 03/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit

// MARK: - FullNameRouter Protocol

protocol FullNameRouterProtocol: AnyObject {
    var controller: UIViewController? { get set }
    
    func routeToEmail(_ username: String?)
}

// MARK: - FullNameRouter Implementation

class FullNameRouter: FullNameRouterProtocol {
    weak var controller: UIViewController?

    // MARK: - Initializer
    
    init() { }
    
    func routeToEmail(_ username: String?) {
        let destination = EmailViewController()
        var destinationDS = destination.router.dataStore
        destinationDS?.username = username
        controller?.navigationController?.pushViewController(destination, animated: true)
    }
}
