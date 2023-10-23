//
//  MovieDetailsRouter.swift
//  MinhasDespesas
//
//  Created by Felipe Augusto Silva on 23/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit

// MARK: - MovieDetailsRouter Protocol

protocol MovieDetailsRouterProtocol: AnyObject {
    var controller: UIViewController? { get set }
}

// MARK: - MovieDetailsRouter Implementation

class MovieDetailsRouter: MovieDetailsRouterProtocol {
    weak var controller: UIViewController?

    // MARK: - Initializer
    
    init() { }
}
