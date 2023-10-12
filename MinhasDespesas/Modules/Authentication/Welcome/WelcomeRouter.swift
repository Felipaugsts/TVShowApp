//
//  WelcomeRouter.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 10/07/23.
//

import Foundation
import UIKit

public protocol WelcomeRouterLogic {
    var controller: UIViewController? { get set }
    
    func routeToLogin()
    func createAccount()
}

public class WelcomeRouter: WelcomeRouterLogic {
    public var controller: UIViewController?
    
    public init() {}
    
    public func routeToLogin() {
        let view = LoginViewController()
        controller?.navigationController?.pushViewController(view, animated: true)
    }
    
    public func createAccount() {
        let destination = FullNameViewController()
        controller?.navigationController?.pushViewController(destination, animated: true)
    }
}
