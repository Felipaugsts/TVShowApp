//
//  LoginInteractor.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 15/07/23.
//

import Foundation
import SDKCommon

public protocol LoginInteractorLogic {
    var presenter: LoginPresenterLogic? { get set }
    
    func authenticate(email: String, password: String)
    func tapForgotPassword()
}

public class LoginInteractor: LoginInteractorLogic {
    
    var service: AuthServiceLogic
    var biometryService: BiometryWorkerLogic
    public var presenter: LoginPresenterLogic?
    
    public init(service: AuthServiceLogic = AuthService(),
                biometryService: BiometryWorkerLogic = BiometryWorker()) {
        self.service = service
        self.biometryService = biometryService
    }
    
    public func authenticate(email: String, password: String) {
        service.authenticate(with: email, password: password) { _, error in
            if let error = error {
                print("Authentication failed with error: \(error)")
            } else {
                self.biometryService.setBiometryEnabled(true)
                self.biometryService.setBiometryData(email, password)
                self.presenter?.presentHomeScreen()
            }
        }
    }
    
    public func tapForgotPassword() {
     
    }
}
