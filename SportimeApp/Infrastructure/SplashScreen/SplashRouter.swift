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
    func routeToLoggedIn()
    func routeHomeView()
}
public class SplashRouter: SplashRouterLogic {
    
    public var controller: UIViewController?
    
    public init() {}
    
    public func routeToLogin() {
        UIApplication.setRootViewControllerWithNavigation(WelcomeViewController())
    }
    
    public func routeToLoggedIn() {
        controller?.navigationController?.pushViewController(LoggedInViewController(), animated: true)
    }
    
    public func routeHomeView() {
        controller?.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
}


