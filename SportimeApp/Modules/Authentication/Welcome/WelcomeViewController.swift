//
//  WelcomeViewController.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 08/07/23.
//

import UIKit

public protocol WelcomeViewControllerLogic {
    func displayScreenValues()
    func displayLogin()
    func displayRegister()
}

public class WelcomeViewController: UIViewController, WelcomeViewControllerLogic {
    
    lazy var background: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "loginBG")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var signInButton: UIButton = {
       let button = UIButton()
        button.tintColor = .blue
        button.backgroundColor = DSColor.primaryDark
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(displayLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: UIButton = {
       let button = UIButton()
        button.tintColor = .blue
        button.backgroundColor = DSColor.primary
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var interactor: WelcomeInteractorLogic
    var presenter: WelcomePresenterLogic
    var router: WelcomeRouterLogic
    
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
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }
    
    func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(registerButton)
        view.addSubview(signInButton)
        view.addSubview(background)
        
        NSLayoutConstraint.activate([
            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            registerButton.heightAnchor.constraint(equalToConstant: 55),
            
            signInButton.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -20),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            signInButton.heightAnchor.constraint(equalToConstant: 55),
            
            background.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            background.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: -80),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
    }
    
    private func setupArch() {
        interactor.presenter = presenter
        presenter.controller = self
        router.controller = self
    }
    
    public func displayScreenValues() {
        signInButton.setTitle("Acessar minha conta", for: .normal)
        registerButton.setTitle("Registrar", for: .normal)
    }
    
    @objc
    public func displayLogin() {
        router.routeToLogin()
    }
    
    public func displayRegister() { }
}
