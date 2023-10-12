//
//  EmailRouter.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 03/10/23.
//  

import UIKit

// MARK: - EmailRouter Protocol

protocol EmailRouterProtocol: AnyObject {
    var controller: UIViewController? { get set }
    func routeToCreatePassword()
}

public protocol EmailDataPassing: AnyObject {
    var dataStore: EmailDataStore? { get set}
}

// MARK: - EmailRouter Implementation

class EmailRouter: NSObject, EmailRouterProtocol, EmailDataPassing {
    weak var controller: UIViewController?
    var dataStore: EmailDataStore?
    // MARK: - Initializer
    
    override init() { }
    
    func routeToCreatePassword() {
        let destination = CreatePasswordViewController()
        var destinationDS = destination.router.dataStore
        passDataToPassword(dataStore: dataStore, destinationDS: &destinationDS)
        controller?.navigationController?.pushViewController(destination, animated: true)
    }
    
    private func passDataToPassword(dataStore: EmailDataStore?, destinationDS: inout CreatePasswordDataStore?) {
        destinationDS?.email = dataStore?.email
        destinationDS?.name = dataStore?.username
    }
}
