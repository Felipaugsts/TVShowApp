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
}

public protocol MoviesDataStore {
    var movie: Movie? { get set }
}

// MARK: - HomeInteractor Implementation

class HomeInteractor: HomeInteractorProtocol, MoviesDataStore {
    weak var presenter: HomePresenterProtocol?
    
    var repository: UserDataSource
    var service: AuthServiceLogic
    var serviceProvider: ServiceProviderProtocol
    
    var movie: Movie?
    
    // MARK: - Initializer
    
    init(repository: UserDataSource = UserRepository.shared,
         service: AuthServiceLogic = AuthService(),
         serviceProvider: ServiceProviderProtocol = ServiceProvider.shared) {
        self.repository = repository
        self.service = service
        self.serviceProvider = serviceProvider
    }
    
    // MARK: - Public Methods
    
    func loadScreenValues() {
        presenter?.presentScreenValues()
        
        serviceProvider.makeAPIRequest(MovieListResponse.self, using: PopularMoviesProvider()) { response in
            print(response)
            switch response {
            case .success(let resp):
                self.presenter?.presentPopulars(movies: resp.results)
            case .failure(_):
                break
            }
        }
    }
}

public struct MovieListResponse: Codable {
    let page: Int
    let results: [Movie] // This assumes that 'results' is an array of movies in your JSON

    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
}

public struct Movie: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

