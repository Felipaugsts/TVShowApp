//
//  HomePresenter.swift
//  MinhasDespesas
//
//  Created by Felipe Augusto Silva on 13/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit

// MARK: - HomePresenter Protocol

protocol HomePresenterProtocol: AnyObject {
    var controller: HomeViewControllerProtocol? { get set }
    
    func presentScreenValues()
    func presentPopulars(movies: [Movie])
    func presentMovieSelected()
}

// MARK: - HomePresenter Implementation

class HomePresenter: HomePresenterProtocol {
    weak var controller: HomeViewControllerProtocol?
    
    // MARK: - Initializer
    
    init() { }
    
    // MARK: - Public Methods
    
    func presentScreenValues() {
        
    }
    
    func presentPopulars(movies: [Movie]) {
        controller?.displayPopulars(movies: movies)
    }
    
    func presentMovieSelected() {
        controller?.displayMovieSelected()
    }
}
