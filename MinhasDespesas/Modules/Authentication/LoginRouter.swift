//
//  LoginRouter.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 15/07/23.
//

import Foundation
import UIKit

// MARK: - Protocol

public protocol LoginRouterLogic {
    var controller: UIViewController? { get set }
    
    func routeToHome()
    func routeToForgotPassword()
}

public  class LoginRouter: LoginRouterLogic {
    public var controller: UIViewController?
    
    // MARK: - Public Methods
    
    public func routeToHome() {
        UIApplication.setRootViewControllerWithNavigation(HomeViewController())
    }
    
    public func routeToForgotPassword() {
        let destination = ForgotPasswordViewController()
        controller?.navigationController?.pushViewController(destination, animated: true)
    }
}
