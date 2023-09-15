//
//  WelcomePresenter.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 08/07/23.
//

import Foundation

public protocol WelcomePresenterLogic: AnyObject {
    var controller: WelcomeViewControllerLogic? { get set }
    
    func presentScreenValues()
    func presentLogin()
}

public class WelcomePresenter: WelcomePresenterLogic {
    
    public var controller: WelcomeViewControllerLogic?
    
    public init () { }
    
    public func presentScreenValues() {
        controller?.displayScreenValues(WelcomeModel.ScreenValues(login: LoginKeys.Localized.welcomeLogin.string(),
                                                                  register: LoginKeys.Localized.welcomeRegister.string()))
    }
    
    public func presentLogin() {
        controller?.displayLogin()
    }
}
