//
//  HomeViewController.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 15/07/23.
//

import UIKit
import SDKCommon

class HomeViewController: UIViewController {

    lazy var confirmButton: Button = {
       let button = Button()
        button.tintColor = .blue
        button.backgroundColor = DSColor.primaryDark
        button.layer.cornerRadius = 16
        button.setTitle("Entrar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(confirmButtonAction), for: .touchUpInside)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            confirmButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 55),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc
    func confirmButtonAction() {
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
}
