//
//  AccountCreatedViewController.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 11/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit
import Lottie

// MARK: - IAccountCreatedViewController

protocol AccountCreatedViewControllerProtocol: AnyObject {
    func displayScreenValues(_ values: AccountCreatedModel.ScreenValues)
}

// MARK: - AccountCreatedViewController

class AccountCreatedViewController: UIViewController {
    
    var interactor: AccountCreatedInteractorProtocol
    var presenter: AccountCreatedPresenterProtocol
    var router: AccountCreatedRouterProtocol
    
    lazy var animationView: LottieAnimationView = {
       var view = LottieAnimationView()
        view = .init(name: "LoyaltyCard")
        view.loopMode = .playOnce
        view.translatesAutoresizingMaskIntoConstraints = false
        view.stop()
        return view
    }()
    
    var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = DSColor.lightest
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    lazy var confirmButton: Button = {
       let button = Button()
        button.tintColor = DSColor.lightest
        button.backgroundColor = DSColor.primary
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(interactor: AccountCreatedInteractorProtocol = AccountCreatedInteractor(),
         presenter: AccountCreatedPresenterProtocol = AccountCreatedPresenter(),
         router: AccountCreatedRouterProtocol = AccountCreatedRouter()) {
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
        
        interactor.loadScreenValues()
        setupConstraints()
        addAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func setup() {
        interactor.presenter = presenter
        presenter.controller = self
        router.controller = self
    }
    
    private func setupConstraints() {
        view.backgroundColor = DSColor.secondary
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(labelTitle)
        view.addSubview(confirmButton)
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            confirmButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            confirmButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            confirmButton.heightAnchor.constraint(equalToConstant: 55),
            
            labelTitle.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -70),
            labelTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            labelTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            
            animationView.bottomAnchor.constraint(equalTo: labelTitle.topAnchor, constant: -50),
            animationView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35),
            animationView.heightAnchor.constraint(equalToConstant: 100),
            animationView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func addAction() {
        confirmButton.addAction {
            self.router.routeToLogin()
        }
    }
}

// MARK: AccountCreatedViewControllerProtocol Implementation

extension AccountCreatedViewController: AccountCreatedViewControllerProtocol {
    
    func displayScreenValues(_ values: AccountCreatedModel.ScreenValues) {
        confirmButton.setButtonTitle(title: "Ok, entendi")
        labelTitle.text = "Sua conta foi criada\ncom sucesso."
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7 ) {
            self.animationView.play()
        }
    }
}
