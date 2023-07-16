//
//  LoggedInViewController.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 15/07/23.
//

import UIKit
import SDKCommon

class LoggedInViewController: UIViewController {

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
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc
    func confirmButtonAction() {
        let biometry = BiometryWorker()
        biometry.authenticate { success in
            if success {
                let (username, password) = biometry.biometryData()
                let service = AuthService()
                service.authenticate(with: username, password: password) { _, err in
                    if err != nil {
                        print("error")
                    } else {
                        self.navigationController?.pushViewController(HomeViewController(), animated: true)
                    }
                }
            } else {
                print("error")
            }
        }
    }
}
