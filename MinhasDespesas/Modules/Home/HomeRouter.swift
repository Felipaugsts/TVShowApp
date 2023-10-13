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
}

// MARK: - HomeRouter Implementation

class HomeRouter: HomeRouterProtocol {
    weak var controller: UIViewController?

    // MARK: - Initializer
    
    init() { }
}
