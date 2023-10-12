//
//  LoginInteractor.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 15/07/23.
//

import Foundation
import SDKCommon

// MARK: - Protocol

public protocol LoginInteractorLogic {
    var presenter: LoginPresenterLogic? { get set }
    
    func authenticate(email: String, password: String)
    func loadValues()
}

public class LoginInteractor: LoginInteractorLogic {
    
    // MARK: -  Variables
    private var service: AuthServiceLogic
    private var biometryService: BiometryWorkerLogic
    
    public var presenter: LoginPresenterLogic?
    
    // MARK: -  Initializers
    
    public init(service: AuthServiceLogic = AuthService(),
                biometryService: BiometryWorkerLogic = BiometryWorker()) {
        self.service = service
        self.biometryService = biometryService
    }
    
    // MARK: -  Public Methods
    
    public func authenticate(email: String, password: String) {
        service.authenticate(with: email, password: password) {[weak self] _, error in
            
            if let error = error {
                switch error {
                case .customError(statusCode: 403, result: nil):
                    self?.presenter?.presentWrongPassword()
                    
                default:
                    break
                }
            } else {
                self?.biometryService.setBiometryEnabled(true)
                self?.biometryService.setBiometryData(email, password)
                self?.presenter?.presentHomeScreen()
            }
        }
    }
    
    public func loadValues() {
        presenter?.presentScreenValues()
    }
}
