//
//  FullNameInteractor.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 03/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit

// MARK: - FullNameInteractor Protocol

protocol FullNameInteractorProtocol: AnyObject {
    var presenter: FullNamePresenterProtocol? { get set }
    
    func loadScreenValues()
    func validate(_ username: String?)
}

// MARK: - FullNameInteractor Implementation

class FullNameInteractor: FullNameInteractorProtocol {
    weak var presenter: FullNamePresenterProtocol?
    

    // MARK: - Initializer
    
    init() { }
    
    // MARK: - Public Methods
    
    func loadScreenValues() {
        presenter?.presentScreenValues()
    }
    
    func validate(_ username: String?) {
        guard let username = username,
        isValidFullName(username) else {
            presenter?.presentInvalidUsername()
            return
        }
        
        presenter?.presentEmail()
    }
    
    private func isValidFullName(_ fullName: String) -> Bool {
        let fullNameRegex = "^[A-Za-z]+( [A-Za-z]+)+$"
        
        if let range = fullName.range(of: fullNameRegex, options: .regularExpression) {
            return range.lowerBound == fullName.startIndex && range.upperBound == fullName.endIndex
        }
        
        return false
    }
}
