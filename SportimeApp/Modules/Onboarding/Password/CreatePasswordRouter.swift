//
//  CreatePasswordRouter.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 10/10/23.
//  

import UIKit

// MARK: - CreatePasswordRouter Protocol

protocol CreatePasswordRouterProtocol: AnyObject {
    var controller: UIViewController? { get set }
    
    func routeToAccountCreated()
}

protocol CreatePasswordRouterDataPassing: AnyObject {
    var dataStore: CreatePasswordDataStore? { get set }
}
// MARK: - CreatePasswordRouter Implementation

class CreatePasswordRouter: NSObject, CreatePasswordRouterProtocol, CreatePasswordRouterDataPassing {
    weak var controller: UIViewController?
    weak var dataStore: CreatePasswordDataStore?

    // MARK: - Initializer
    
    override init() { }
    
    func routeToAccountCreated(){
        let destination = AccountCreatedViewController()
        controller?.navigationController?.pushViewController(destination, animated: true)
    }
}
