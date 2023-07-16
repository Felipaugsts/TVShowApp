//
//  LoginPresenter.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 15/07/23.
//

import Foundation

public protocol LoginPresenterLogic {
    var controller: LoginViewControllerLogic? { get set }
    
    func presentHomeScreen()
}

public class LoginPresenter: LoginPresenterLogic {
    public var controller: LoginViewControllerLogic?
    
    public init() { }
    
    public func presentHomeScreen() {
        controller?.displayHomeScreen()
    }
}
