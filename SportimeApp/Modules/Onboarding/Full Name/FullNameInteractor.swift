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
}
