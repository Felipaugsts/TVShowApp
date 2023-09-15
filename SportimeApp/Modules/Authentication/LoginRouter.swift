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
}

public  class LoginRouter: LoginRouterLogic {
    public var controller: UIViewController?
    
    // MARK: - Public Methods
    
    public func routeToHome() {
        controller?.navigationController?.pushViewController(HomeViewController(), animated: false)
        controller?.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
}
