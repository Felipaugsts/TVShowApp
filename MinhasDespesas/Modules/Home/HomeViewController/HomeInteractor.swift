//
//  HomeInteractor.swift
//  MinhasDespesas
//
//  Created by Felipe Augusto Silva on 13/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit
import SDKCommon

// MARK: - HomeInteractor Protocol

protocol HomeInteractorProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    
    func loadScreenValues()
    func didSelectMovie(_ movie: Movie)
}

public protocol MoviesDataStore {
    var movie: Movie? { get set }
}

// MARK: - HomeInteractor Implementation

class HomeInteractor: HomeInteractorProtocol, MoviesDataStore {
    weak var presenter: HomePresenterProtocol?
    
    var worker: HomeWorkerLogic
    var movie: Movie?
    
    // MARK: - Initializer
    
    init(worker: HomeWorkerLogic = HomeWorker()) {

        self.worker = worker
    }
    
    // MARK: - Public Methods
    
    func loadScreenValues() {
        presenter?.presentScreenValues()
        
        worker.fetchPopularMovies(MovieListResponse.self, using: PopularMoviesProvider()) { response in
            print(response)
            switch response {
            case .success(let resp):
                self.presenter?.presentPopulars(movies: resp.results)
            case .failure(_):
                break
            }
        }
    }
    
    func didSelectMovie(_ movie: Movie) {
        self.movie = movie
        presenter?.presentMovieSelected()
    }
}
