//
//  HomeIncome+Extension.swift
//  MinhasDespesas
//
//  Created by Felipe Augusto Silva on 13/10/23.
//

import Foundation

extension HomeInteractor {
   
    func loadMonthsValues() {
        let income = BudgetMonthDate(totalIncome: getSummedIncome() ?? "",
                                     currentMonth: getDateComponent())
        
        presenter?.presentScreenValues(income: income)
    }
    
    func formatAsMoney(_ amount: Int) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "$"
        numberFormatter.maximumFractionDigits = 2

        if let formattedAmount = numberFormatter.string(from: NSNumber(value: amount)) {
            return formattedAmount
        } else {
            return "$ 0,00"
        }
    }
    
    func getDateComponent() -> String {
        let currentDate = String(currentMonthDisplayed)
        let monthNumbers = ["1": "January", "2": "February", "3": "March", "4": "April", "5": "May", "6": "June", "7": "July", "8": "August", "9": "September", "10": "October", "11": "November", "12": "December"]
        
        return monthNumbers[currentDate] ?? ""
    }
    
    func getCurrentMonth() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        
        if let currentMonth = Int(dateFormatter.string(from: Date())) {
            currentMonthDisplayed = currentMonth
        }
    }
    
    func getSummedIncome(forDate date: String? = nil) -> String? {
        var currentDate: String = String(currentMonthDisplayed)
        
        if let date = date {
            currentDate = date
            currentMonthDisplayed = Int(date) ?? 0
        }
        
        guard let currentMonthIncome = repository.user?.budget?.yearBudget.getCurrentMonthData(forMonth: currentDate) else {
            return nil
        }
        var total = 0
        
        currentMonthIncome.incoming.first?.people.forEach({ person in
            total += person.value
        })
        
        return formatAsMoney(total)
    }
}

