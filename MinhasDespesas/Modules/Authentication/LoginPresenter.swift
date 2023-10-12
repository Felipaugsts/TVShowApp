//
//  LoginPresenter.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 15/07/23.
//

import Foundation

// MARK: - Protocol

public protocol LoginPresenterLogic {
    var controller: LoginViewControllerLogic? { get set }
    
    func presentHomeScreen()
    func presentWrongPassword()
    func presentScreenValues()
}

public class LoginPresenter: LoginPresenterLogic {
    public var controller: LoginViewControllerLogic?
    
    public init() { }
    
    // MARK: - Public Methods 
    
    public func presentHomeScreen() {
        controller?.displayHomeScreen()
    }
    
    public func presentWrongPassword() {
        controller?.displayWrongPassword()
    }
    
    public func presentScreenValues() {
        controller?.displayScreenValues(LoginModel.ScreenValues(title: LoginKeys.Localized.loginTitle.string(),
                                                                textFieldText: LoginKeys.Localized.username.string(),
                                                                passwordText: LoginKeys.Localized.password.string(),
                                                                confirmButton: LoginKeys.Localized.confirmButton.string(),
                                                                forgotPassword: LoginKeys.Localized.forgotPassword.string()))
    }
}
