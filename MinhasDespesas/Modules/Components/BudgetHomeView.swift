//
//  BudgetHomeView.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 28/09/23.
//

import Foundation
import UIKit
import SDKCommon

protocol BudgetHomeViewDelegate: AnyObject {
    func tapAddExpense()
    func tapSelectDate()
}

class BudgetHomeView: UIView {
    
    // MARK: - Components
    
    public var budgetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.textColor = DSColor.white // Assuming DSColor is defined elsewhere
        label.translatesAutoresizingMaskIntoConstraints = false // Important for Auto Layout
        return label
    }()
    
    let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = DSColor.primary
        return view
    }()
    
    public var priceTotalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total"
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = DSColor.darkest // Assuming DSColor is defined elsewhere
        label.translatesAutoresizingMaskIntoConstraints = false // Important for Auto Layout
        return label
    }()
    
    
    public var currentMonthLabel: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("2023", for: .normal)
        button.titleLabel?.font = .circularBook(size: 20)
        return button
    }()
    
    public var yearDisplayed: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("2023", for: .normal)
        button.titleLabel?.font = .circularBook(size: 14)
        return button
    }()
    
    public var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$5,023"
        label.font = UIFont.systemFont(ofSize: 36.0)
        label.textColor = DSColor.darkest
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var budgeInsideView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = DSColor.white
        view.layer.cornerRadius = 20
        
        // Add shadow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 1
        
        return view
    }()
    
    var addExpenseButton: UIButton = {
        let button = UIButton()
        
        // Set button appearance
        button.backgroundColor = DSColor.primary
        button.layer.cornerRadius = 25 // Makes the button circular
        
        // Add arrow icon
        let arrowImage = UIImage(systemName: "plus")
        button.setImage(arrowImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 2
        return button
    }()
    
    weak var delegate: BudgetHomeViewDelegate?
    public var data: BudgetMonthDate? {
        didSet {
            priceLabel.text = data?.totalIncome
            currentMonthLabel.setTitle(data?.currentMonth ?? "", for: .normal)
        }
    }
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        addActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Layout
    
    func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = DSColor.white
        
        addComponents()
        setupConstrainst()
    }
    
    private func addComponents() {
        addSubview(backgroundView)
        addSubview(budgeInsideView)
        
        backgroundView.addSubview(currentMonthLabel)
        backgroundView.addSubview(yearDisplayed)
        
        budgeInsideView.addSubview(priceLabel)
        budgeInsideView.addSubview(priceTotalLabel)
        budgeInsideView.addSubview(addExpenseButton)
        
        currentMonthLabel.bringSubviewToFront(backgroundView)
    }
    
    private func setupConstrainst() {
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundView.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: 200),
            currentMonthLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor, constant: -25),
            currentMonthLabel.rightAnchor.constraint(equalTo: backgroundView.rightAnchor),
            currentMonthLabel.leftAnchor.constraint(equalTo: backgroundView.leftAnchor),
            
            yearDisplayed.topAnchor.constraint(equalTo: currentMonthLabel.bottomAnchor, constant: -10),
            yearDisplayed.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            
            budgeInsideView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            budgeInsideView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            budgeInsideView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            budgeInsideView.heightAnchor.constraint(equalToConstant: 150),
            
            priceLabel.leftAnchor.constraint(equalTo: budgeInsideView.leftAnchor, constant: 15),
            priceLabel.centerYAnchor.constraint(equalTo: budgeInsideView.centerYAnchor),
            priceTotalLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -5),
            priceTotalLabel.leftAnchor.constraint(equalTo: budgeInsideView.leftAnchor, constant: 15),
            
            addExpenseButton.rightAnchor.constraint(equalTo: budgeInsideView.rightAnchor, constant: -15),
            addExpenseButton.widthAnchor.constraint(equalToConstant: 50),
            addExpenseButton.heightAnchor.constraint(equalToConstant: 50),
            addExpenseButton.centerYAnchor.constraint(equalTo: budgeInsideView.centerYAnchor)
        ])
    }
    
    func addActions() {
        addExpenseButton.addTarget(self, action: #selector(tapAddExpense), for: .touchUpInside)
        
        backgroundView.addTapGesture(target: self, action: #selector(tapSelect))
        
        currentMonthLabel.addAction {
            self.tapSelect()
        }
        
        yearDisplayed.addAction {
            self.tapSelect()
        }
    }
    
    @objc
    func tapSelect() {
        delegate?.tapSelectDate()
    }
    
    @objc
    func tapAddExpense() {
        delegate?.tapAddExpense()
    }
}

public struct BudgetMonthDate {
    public var totalIncome: String
    public var currentMonth: String
}

extension Array where Element == MonthData {
    func getCurrentMonthData(forMonth month: String) -> MonthData? {
        return first { $0.month == month }
    }
}
