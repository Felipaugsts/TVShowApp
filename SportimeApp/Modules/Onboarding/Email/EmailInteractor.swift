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
        guard let email = email else {
            return
        }
        self.email = email
        presenter?.presentCreatePassword()
    }
}
