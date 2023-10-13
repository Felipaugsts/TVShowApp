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
    func selectDisplayedMonth()
    func displayDatafrom(month: Int?)
}

// MARK: - HomeInteractor Implementation

class HomeInteractor: HomeInteractorProtocol {
    weak var presenter: HomePresenterProtocol?
    
    var budgetData: [MonthData]?
    var currentMonthDisplayed = 0 {
        didSet {
            loadMonthsValues()
        }
    }
    
    var repository: UserDataSource
    // MARK: - Initializer
    
    init(repository: UserDataSource = UserRepository.shared) {
        self.repository = repository
    }
    
    // MARK: - Public Methods
    
    func loadScreenValues() {
        getCurrentMonth()
        budgetData = repository.user?.budget?.yearBudget
        loadMonthsValues()
    }
    
    func selectDisplayedMonth() {
        presenter?.presentMonthPicker(currentMonthDisplayed)
    }
    
    func displayDatafrom(month: Int?) {
        guard let toDisplay = month,
              toDisplay == currentMonthDisplayed else {
            currentMonthDisplayed = month ?? 0
            return
        }
    }
}
