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

public protocol HomeRouterDataPassing: AnyObject {
    var dataStore: MoviesDataStore? { get set}
}

// MARK: - HomeRouter Implementation

class HomeRouter: NSObject, HomeRouterProtocol, HomeRouterDataPassing {
    weak var controller: UIViewController?

    // MARK: - Initializer
    var dataStore: MoviesDataStore?
    
    override init() { }

}








class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set this class as the navigation controller's delegate
        self.delegate = self
    }

    // Function to set a new root view controller
    func setRootViewController(_ viewController: UIViewController) {
        // Pop to the root view controller, removing all previous view controllers
        popToRootViewController(animated: false)
        // Set the new root view controller
        setViewControllers([viewController], animated: true)
        self.navigationBar.barTintColor = .black
        navigationBar.isTranslucent = false
    }
}
