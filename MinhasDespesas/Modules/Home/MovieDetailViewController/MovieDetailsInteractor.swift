//
//  MovieDetailsInteractor.swift
//  MinhasDespesas
//
//  Created by Felipe Augusto Silva on 23/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit

// MARK: - MovieDetailsInteractor Protocol

protocol MovieDetailsInteractorProtocol: AnyObject {
    var presenter: MovieDetailsPresenterProtocol? { get set }
    
    func loadScreenValues()
}

// MARK: - MovieDetailsInteractor Implementation

class MovieDetailsInteractor: MovieDetailsInteractorProtocol {
    weak var presenter: MovieDetailsPresenterProtocol?

    // MARK: - Initializer
    
    init() { }
    
    // MARK: - Public Methods
    
    func loadScreenValues() {
        presenter?.presentScreenValues()
    }
}
