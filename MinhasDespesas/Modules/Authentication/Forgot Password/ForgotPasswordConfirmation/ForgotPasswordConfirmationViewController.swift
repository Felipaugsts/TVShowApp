//
//  ForgotPasswordConfirmationViewController.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 11/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit
import Lottie

// MARK: - IForgotPasswordConfirmationViewController

protocol ForgotPasswordConfirmationViewControllerProtocol: AnyObject {
    func displayScreenValues(_ values: ForgotPasswordConfirmationModel.ScreenValues)
}

// MARK: - ForgotPasswordConfirmationViewController

class ForgotPasswordConfirmationViewController: UIViewController {
    
    lazy var animationView: LottieAnimationView = {
       var view = LottieAnimationView()
        view = .init(name: "Mailbox")
        view.loopMode = .autoReverse
        view.translatesAutoresizingMaskIntoConstraints = false
        view.stop()
        return view
    }()
    
    var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = DSColor.lightest
        label.numberOfLines = 0
        label.font = .circularBold(size: 32)
        label.textAlignment = .left
        return label
    }()
    
    var labelSubtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = DSColor.medium
        label.numberOfLines = 0
        label.font = .circularBook(size: 16)
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
    
    var interactor: ForgotPasswordConfirmationInteractorProtocol
    var presenter: ForgotPasswordConfirmationPresenterProtocol
    var router: ForgotPasswordConfirmationRouterProtocol
    
    init(interactor: ForgotPasswordConfirmationInteractorProtocol = ForgotPasswordConfirmationInteractor(),
         presenter: ForgotPasswordConfirmationPresenterProtocol = ForgotPasswordConfirmationPresenter(),
         router: ForgotPasswordConfirmationRouterProtocol = ForgotPasswordConfirmationRouter()) {
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
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = false
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
        view.addSubview(labelSubtitle)
        
        NSLayoutConstraint.activate([
            confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            confirmButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            confirmButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            confirmButton.heightAnchor.constraint(equalToConstant: 55),
            
            labelSubtitle.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -70),
            labelSubtitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            labelSubtitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            
            labelTitle.bottomAnchor.constraint(equalTo: labelSubtitle.topAnchor, constant: -20),
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

// MARK: ForgotPasswordConfirmationViewControllerProtocol Implementation

extension ForgotPasswordConfirmationViewController: ForgotPasswordConfirmationViewControllerProtocol {
    
    func displayScreenValues(_ values: ForgotPasswordConfirmationModel.ScreenValues) {
        labelTitle.text = "Verifique seu email."
        labelSubtitle.text = "Caso haja uma conta com este email\nenviaremos uma nova senha."
        confirmButton.setButtonTitle(title: "Ok, entendi")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.animationView.play()
        }
    }
}
