//
//  CreatePasswordInteractor.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 10/10/23.

import UIKit
import SDKCommon

// MARK: - CreatePasswordInteractor Protocol

protocol CreatePasswordInteractorProtocol: AnyObject {
    var presenter: CreatePasswordPresenterProtocol? { get set }
    
    func loadScreenValues()
    func validate(password: String?)
}

public protocol CreatePasswordDataStore: AnyObject {
    var email: String? { get set }
    var name: String? { get set }
}

// MARK: - CreatePasswordInteractor Implementation

class CreatePasswordInteractor: CreatePasswordInteractorProtocol, CreatePasswordDataStore {
    weak var presenter: CreatePasswordPresenterProtocol?
    var email: String?
    var name: String?
    
    private var firstPassword = false
    private var service: AuthServiceLogic
    private var password: String = ""
    
    // MARK: - Initializer
    
    init(service: AuthServiceLogic = AuthService()) {
        self.service = service
    }
    
    // MARK: - Public Methods
    
    func loadScreenValues() {
        presenter?.presentScreenValues()
    }
    
    func validate(password: String?) {
        guard let password = password else {
            presenter?.presentInvalidPassword()
            return
        }
        
        if !firstPassword {
            firstPassword = true
            self.password = password
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.presenter?.presentConfirmPassword()
            }
            return
        }
        
        guard let email = email, self.password == password else {
            handlePasswordMismatch()
            return
        }
        
        createAccount(email: email, password: password)
    }

    private func handlePasswordMismatch() {
        password = ""
        firstPassword = false
        presenter?.presentInvalidPassword()
    }

    private func createAccount(email: String, password: String) {
        service.createAccount(email: email, password: password) { _, error in
            if let error = error {
                print(error)
            } else {
                self.updateUserProfile()
            }
        }
    }

    
    private func updateUserProfile() {
        guard let name = name else {
            logout()
            presenter?.presentAccountCreated()
            return
        }
        
        service.updateUsername(name) { _, error in
            self.logout()
            self.presenter?.presentAccountCreated()
        }
    }
    
    private func logout() {
        service.logout { _, _ in
            print("logged out")
        }
    }
}
