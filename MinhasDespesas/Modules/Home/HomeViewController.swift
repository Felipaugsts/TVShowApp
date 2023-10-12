//
//  HomeViewController.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 15/07/23.
//

import UIKit
import SDKCommon

class HomeViewController: UIViewController {

    let budgetView = BudgetHomeView()
    
    override var prefersStatusBarHidden: Bool {
         return true
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        addbudgetViewToHome()
    }
}

extension HomeViewController: BudgetHomeViewDelegate {
    func tapAddExpense() {
        let service = AuthService()
        service.logout { _, error in
            if error != nil {
                return
            }
            
            let destination = LoginViewController()
            destination.navigationItem.hidesBackButton = true
            destination.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            self.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    func addbudgetViewToHome() {
        budgetView.delegate = self
        
        view.addSubview(budgetView)
        
        NSLayoutConstraint.activate([
            budgetView.topAnchor.constraint(equalTo: view.topAnchor),
            budgetView.leftAnchor.constraint(equalTo: view.leftAnchor),
            budgetView.rightAnchor.constraint(equalTo: view.rightAnchor),
            budgetView.heightAnchor.constraint(equalToConstant: view.frame.height / 3)
        ])
    }
}
