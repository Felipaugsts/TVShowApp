//
//  SplashRouter.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 08/07/23.
//

import Foundation
import UIKit

public protocol SplashRouterLogic {
    var controller: UIViewController? { get set }
    
    func routeToLogin()
}
public class SplashRouter: SplashRouterLogic {
    
    public var controller: UIViewController?
    
    public init() {}
    
    public func routeToLogin() {
        controller?.navigationController?.pushViewController(WelcomeViewController(), animated: false)
    }
}


