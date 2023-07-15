//
//  LoginInteractor.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 15/07/23.
//

import Foundation

public protocol LoginInteractorLogic {
    func authenticate(email: String, password: String)
}

public class LoginInteractor: LoginInteractorLogic {
    
    var service: AuthServiceLogic
    
    public init(service: AuthServiceLogic = AuthService()) {
        self.service = service
    }
    
    public func authenticate(email: String, password: String) {
        service.authenticate(with: email, password: password) { _, error in
            if let error = error {
                print("Authentication failed with error: \(error)")
            } else {
                print("Authentication successful", UserRepository.shared.user)
            
            }
        }
    }
}
