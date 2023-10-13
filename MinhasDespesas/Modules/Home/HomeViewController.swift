//
//  HomeViewController.swift
//  MinhasDespesas
//
//  Created by Felipe Augusto Silva on 13/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit
import SnapKit
import SDKCommon

// MARK: - IHomeViewController

protocol HomeViewControllerProtocol: AnyObject {
    func displayScreenValues(_ values: HomeModel.ScreenValues)
    func displayMonthPicker(_ showAt: Int)
}

// MARK: - HomeViewController

class HomeViewController: UIViewController {
    
    lazy var budgetView: BudgetHomeView = {
       let budget = BudgetHomeView()
        budget.delegate = self
        return budget
    }()
    
    lazy var pickerTextField: KeyboardPickerTextField = {
        let pickerview = KeyboardPickerTextField()
        pickerview.setPickerDelegate(self)
        pickerview.isHidden = true
        return pickerview
    }()
    
    var interactor: HomeInteractorProtocol
    var presenter: HomePresenterProtocol
    var router: HomeRouterProtocol
    
    init(interactor: HomeInteractorProtocol = HomeInteractor(),
         presenter: HomePresenterProtocol = HomePresenter(),
         router: HomeRouterProtocol = HomeRouter()) {
        self.interactor = interactor
        self.presenter = presenter
        self.router = router
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        interactor.loadScreenValues()
        setupLayout()
    }
    
    private func setup() {
        interactor.presenter = presenter
        presenter.controller = self
        router.controller = self
    }
    
    private func setupLayout() {
        view.addSubview(budgetView)
        view.addSubview(pickerTextField)
        
        budgetView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(view.frame.height / 3)
        }
    }
}

// MARK: HomeViewControllerProtocol Implementation

extension HomeViewController: HomeViewControllerProtocol, BudgetHomeViewDelegate, KeyboardPickerDelegate {
    
    func didSelectOption(_ option: String) {
        interactor.displayDatafrom(month: Int(option))
    }
    
    func tapAddExpense() {
        let option1 = UIAlertAction(title: "Gastos", style: .default) { _ in
            print("Gastos")
        }
        
        let option2 = UIAlertAction(title: "Renda", style: .default) { _ in
            print("Renda")
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            AuthService().logout { _, error in
                if error != nil {
                    return
                }
                
                let destination = LoginViewController()
                destination.navigationItem.hidesBackButton = true
                destination.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                self.navigationController?.pushViewController(destination, animated: true)
            }
        }
        
        CustomActionSheet.presentActionSheet(from: self, title: nil, message: nil, actions: [option1, option2, cancel])
    }
    
    func tapSelectDate() {
        interactor.selectDisplayedMonth()
    }
    
    func displayScreenValues(_ values: HomeModel.ScreenValues) {
        budgetView.data = values.income
        pickerTextField.setPickerData(values.monthData)
    }
    
    func displayMonthPicker(_ showAt: Int) {
        let index = showAt - 1
        pickerTextField.showPicker(at: index)
    }
}
