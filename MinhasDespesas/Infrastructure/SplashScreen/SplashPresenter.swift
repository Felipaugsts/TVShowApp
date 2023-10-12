//
//  SplashPresenter.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 08/07/23.
//

import Foundation

public protocol SplashPresenter: AnyObject {
    var controller: SplashViewControllerProtocol? { get set }
    
    func presentScreenValues()
    func presentLogin()
    func presentLoggedIn()
    func presentHomeView()
}

public class SplashPresenterDefault: SplashPresenter {
    public var controller: SplashViewControllerProtocol?
    
    public init () { }
    
    public func presentScreenValues() {
        controller?.displayScreenValue()
    }
    
    public func presentLogin() {
        controller?.navigateToLogin()
    }
    
    public func presentLoggedIn() {
        controller?.displayLoggedIn()
    }
    
    public func presentHomeView() {
        controller?.displayHomeView()
    }
}
