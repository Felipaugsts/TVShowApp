//
//  MovieDetailsPresenter.swift
//  MinhasDespesas
//
//  Created by Felipe Augusto Silva on 23/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit

// MARK: - MovieDetailsPresenter Protocol

protocol MovieDetailsPresenterProtocol: AnyObject {
    var controller: MovieDetailsViewControllerProtocol? { get set }
    
    func presentScreenValues(movie: Movie)
}

// MARK: - MovieDetailsPresenter Implementation

class MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    weak var controller: MovieDetailsViewControllerProtocol?

    // MARK: - Initializer
    
    init() { }
    
    // MARK: - Public Methods
    
    func presentScreenValues(movie: Movie) {
        let values = MovieDetailsModel.ScreenValues(movie: movie)
        controller?.displayScreenValues(values)
    }
}
