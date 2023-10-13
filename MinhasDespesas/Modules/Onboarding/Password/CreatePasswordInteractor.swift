//
//  CreatePasswordInteractor.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 10/10/23.

import UIKit
import SDKCommon

// MARK: - CreatePasswordInteractor Protocol

protocol CreatePasswordInteractorProtocol: AnyObject {
    var presenter: CreatePasswordPresenterProtocol? { get set }
    
    func loadScreenValues()
    func validate(password: String?)
}

public protocol CreatePasswordDataStore: AnyObject {
    var email: String? { get set }
    var name: String? { get set }
}

// MARK: - CreatePasswordInteractor Implementation

class CreatePasswordInteractor: CreatePasswordInteractorProtocol, CreatePasswordDataStore {
    weak var presenter: CreatePasswordPresenterProtocol?
    var email: String?
    var name: String?
    
    private var firstPassword = false
    private var service: AuthServiceLogic
    private var networkService: ServiceProviderProtocol
    private var password: String = ""
    
    // MARK: - Initializer
    
    init(service: AuthServiceLogic = AuthService(),
         networkService: ServiceProviderProtocol = ServiceProvider.shared) {
        self.service = service
        self.networkService = networkService
    }
    
    // MARK: - Public Methods
    
    func loadScreenValues() {
        presenter?.presentScreenValues()
    }
    
    func validate(password: String?) {
        guard let password = password else {
            presenter?.presentInvalidPassword()
            return
        }
        
        if !firstPassword {
            firstPassword = true
            self.password = password
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.presenter?.presentConfirmPassword()
            }
            return
        }
        
        guard let email = email, self.password == password else {
            handlePasswordMismatch()
            return
        }
        
        createAccount(email: email, password: password)
    }

    private func handlePasswordMismatch() {
        password = ""
        firstPassword = false
        presenter?.presentInvalidPassword()
    }

    private func createAccount(email: String, password: String) {
        service.createAccount(email: email, password: password) { _, error in
            if error != nil {
                self.logout()
            } else {
                self.setInitialBudget()
                self.setUser()
            }
        }
    }
    
    private func setUser() {
        guard let userInfo = service.getCurrentUser(), let id = userInfo.uid else {
            return
        }

        var user = CreatePasswordModel.User() // Initialize a User instance
        user.name = name
        user.email = userInfo.email
        user.userUID = id

        service.createFirestoreDocument(collectionName: "Users", documentID: id, data: user) { _ in
        }
    }

    
    private func setInitialBudget() {
        let months = getMonths()
        let year = getDateComponentAsString(dateFormat: "yyyy")
        let yearBudget = YearBudget(year: Int(year) ?? 0,
                                    yearBudget: months)
        guard let userID = service.getCurrentUser()?.uid else {
            return
        }
        
        service.createFirestoreDocument(collectionName: "Budget", documentID: userID, data: yearBudget) { response in
            self.logout()
        }
    }
    
    private func getMonths() -> [MonthData] {
        var yearBudget: [MonthData] = []
        
        for month in 1...12 { // Loop through 12 months
            let monthString = String(format: "%02d", month) // Format month as "MM"
            
            // Create a MonthData instance for the current month
            let monthData = MonthData(
                month: monthString,
                incoming: [
                    IncomingData(
                        totalIncoming: 0,
                        people: [
                            PersonData(personId: 0, name: "", value: 0)
                        ]
                    )
                ],
                expenses: [
                    ExpenseData(
                        totalExpenses: 0,
                        creditCards: [],
                        house: [],
                        education: []
                    )
                ]
            )
            
            yearBudget.append(monthData)
        }
        return yearBudget
    }
    
    private func logout() {
        service.logout { _, _ in
            self.presenter?.presentAccountCreated()
        }
    }
    
    func getDateComponentAsString(date: Date? = nil, dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        if let date = date {
            return dateFormatter.string(from: date)
        }
        
        // If no date is provided, use the current date
        let currentDate = Date()
        return dateFormatter.string(from: currentDate)
    }
}
