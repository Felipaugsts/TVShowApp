//
//  HomeRouter.swift
//  MinhasDespesas
//
//  Created by Felipe Augusto Silva on 13/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit

// MARK: - HomeRouter Protocol

protocol HomeRouterProtocol: AnyObject {
    var controller: UIViewController? { get set }
    
    func routeToMovieSelected()
    
}

public protocol HomeRouterDataPassing: AnyObject {
    var dataStore: MoviesDataStore? { get set}
}

// MARK: - HomeRouter Implementation

class HomeRouter: NSObject, HomeRouterProtocol, HomeRouterDataPassing {
    weak var controller: UIViewController?

    // MARK: - Initializer
    var dataStore: MoviesDataStore?
    
    override init() { }
    
    func routeToMovieSelected() {
        let newViewController = MovieDetailsViewController()
        var destination = newViewController.router.dataStore
        passDatatoMovieSelected(datastore: dataStore, destinationDataStore: &destination)
        controller?.navigationController?.pushViewController(newViewController, animated: true)
    }

    func passDatatoMovieSelected(datastore: MoviesDataStore?, destinationDataStore: inout MoviesDataStore?) {
        destinationDataStore?.movie = datastore?.movie
    }
}
