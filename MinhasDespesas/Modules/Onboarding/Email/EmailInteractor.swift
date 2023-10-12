//
//  EmailInteractor.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 03/10/23.

import UIKit

// MARK: - EmailInteractor Protocol

protocol EmailInteractorProtocol: AnyObject {
    var presenter: EmailPresenterProtocol? { get set }
    
    func loadScreenValues()
    func validate(_ email: String?)
}

public protocol EmailDataStore {
    var email: String? { get set }
    var username: String? { get set }
}

// MARK: - EmailInteractor Implementation

class EmailInteractor: EmailInteractorProtocol, EmailDataStore {
    weak var presenter: EmailPresenterProtocol?

    var email: String?
    var username: String?
    
    // MARK: - Initializer
    
    init() { }
    
    // MARK: - Public Methods
    
    func loadScreenValues() {
        presenter?.presentScreenValues()
    }
    
    func validate(_ email: String?) {
        guard let email = email,
        isValidEmail(email) else {
            presenter?.presentInvalidEmail()
            return
        }
        self.email = email
        presenter?.presentCreatePassword()
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        
        if let range = email.range(of: emailRegex, options: .regularExpression) {
            return range.lowerBound == email.startIndex && range.upperBound == email.endIndex
        }
        
        return false
    }
}
