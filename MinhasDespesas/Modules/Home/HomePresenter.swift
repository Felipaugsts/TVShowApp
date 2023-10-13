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
    
    func presentScreenValues(income: BudgetMonthDate)
    func presentMonthPicker(_ showAt: Int)
}

// MARK: - HomePresenter Implementation

class HomePresenter: HomePresenterProtocol {
    weak var controller: HomeViewControllerProtocol?
    
    // MARK: - Initializer
    
    init() { }
    
    // MARK: - Public Methods
    
    func presentScreenValues(income: BudgetMonthDate) {
        let values = HomeModel.ScreenValues(example: "example", income: income, monthData: monthData())
        controller?.displayScreenValues(values)
    }
    
    func presentMonthPicker(_ showAt: Int) {
        controller?.displayMonthPicker(showAt)
    }
    
    private func monthData() -> [String] {
        [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December"
        ]
    }
}
