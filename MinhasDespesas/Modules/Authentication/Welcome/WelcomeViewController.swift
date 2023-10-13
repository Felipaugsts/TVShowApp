//
//  WelcomeViewController.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 08/07/23.
//

import UIKit
import SDKCommon

// MARK: - Protocol

public protocol WelcomeViewControllerLogic {
    func displayScreenValues(_ values: WelcomeModel.ScreenValues)
    func displayLogin()
    func displayRegister()
}

public class WelcomeViewController: UIViewController {
    
    // MARK: - Components
    
    lazy var background: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "welcomebackground")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton()
        button.tintColor = .blue
        button.backgroundColor = DSColor.primary
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(displayLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(DSColor.darkest, for: .normal) // Set text color to black
        button.backgroundColor = DSColor.light
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(displayRegister), for: .touchUpInside)
        return button
    }()

    
    
    // MARK: - Variables
    
    var interactor: WelcomeInteractorLogic
    var presenter: WelcomePresenterLogic
    var router: WelcomeRouterLogic
    
    // MARK: - Initializer
    
    public init(interactor: WelcomeInteractorLogic = WelcomeInteractor(),
                presenter: WelcomePresenterLogic = WelcomePresenter(),
                router: WelcomeRouterLogic = WelcomeRouter()) {
        self.interactor = interactor
        self.presenter = presenter
        self.router = router
        
        super.init(nibName: nil, bundle: nil)
        setupArch()
        
        interactor.loadScreenValues()
    }
    
    public required init?(coder: NSCoder) {
        return nil
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(background)
        view.addSubview(registerButton)
        view.addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            registerButton.heightAnchor.constraint(equalToConstant: 55),
            
            signInButton.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -20),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            signInButton.heightAnchor.constraint(equalToConstant: 55),
            
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupArch() {
        interactor.presenter = presenter
        presenter.controller = self
        router.controller = self
    }
}

// MARK: - Extension

extension WelcomeViewController: WelcomeViewControllerLogic {
    public func displayScreenValues(_ values: WelcomeModel.ScreenValues) {
        signInButton.setTitle(values.login, for: .normal)
        registerButton.setTitle(values.register, for: .normal)
    }
    
    
    @objc
    public func displayLogin() {
        router.routeToLogin()
    }
    
    @objc
    public func displayRegister() {
        router.createAccount()
    }
    
}
