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
        
//        service.createFirestoreDocument(collectionName: "Users", documentID: id, data: user) { _ in
//            self.setInitialBudget()
//        }
    }

    
    private func setInitialBudget() {
//        let (month, year) = extractMonthAndYear() ?? ("", "")
//        guard let userID = service.getCurrentUser()?.uid else {
//            return
//        }
//        guard let months = getMonths(month: month) else { return }
//
//        let db = Firestore.firestore()
//        let userCollection = db.collection("Users").document(userID)
//        userCollection.collection(year).document(month).setData(months, merge: true) { error in
//            guard let error = error else {
//                self.presenter?.presentAccountCreated()
//                return
//            }
//
//            print(error.localizedDescription)
//        }
    }
    
    private func getMonths(month: String) -> [String: Any]? {
        let data = MonthData(
            month: month,
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
        
        do {
            let jsonString = try data.toDictionary()
            return jsonString
        } catch {
            return nil
        }
    }
    
    private func logout() {
        service.logout { _, _ in
            self.presenter?.presentAccountCreated()
        }
    }
    
    func extractMonthAndYear() -> (String, String)? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy" // Define the date format

        // Format the current date as a string
        let dateString = dateFormatter.string(from: Date())
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let monthNumber = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            
            let monthString = String(monthNumber)
            let yearString = String(year)
            
            return (monthString, yearString)
        }

        return nil
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

extension Encodable {
    func toDictionary() throws -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try encoder.encode(self)
        
        if let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
            return dictionary
        } else {
            throw EncodingError.invalidValue(self, EncodingError.Context(codingPath: [], debugDescription: "Failed to convert to dictionary"))
        }
    }
}
