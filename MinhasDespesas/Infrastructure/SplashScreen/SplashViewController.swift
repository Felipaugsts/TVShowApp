//
//  SplashViewController.swift
//  SportimeApp
//
//  Created by Felipe Augusto Silva on 08/07/23.
//

import UIKit
import Lottie

public protocol SplashViewControllerProtocol {
    func displayScreenValue()
    func navigateToLogin()
    func displayLoggedIn()
    func displayHomeView()
}

public class SplashViewController: UIViewController, SplashViewControllerProtocol {

    public override var prefersStatusBarHidden: Bool {
         return true
     }
    
    lazy var animationView: LottieAnimationView = {
       var view = LottieAnimationView()
        view = .init(name: "splash")
        view.loopMode = .playOnce
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var interactor: SplashInteractor
    var presenter: SplashPresenter
    var router: SplashRouterLogic
    
    public init(interactor: SplashInteractor = SplashInteractorDefault(),
                presenter: SplashPresenter = SplashPresenterDefault(),
                router: SplashRouterLogic = SplashRouter()) {
        self.interactor = interactor
        self.presenter = presenter
        self.router = router
        
        super.init(nibName: nil, bundle: nil)
        setup()
        interactor.loadScreenValues()
    }
    
    public required init?(coder: NSCoder) {
        nil
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLottie()
    }
    
    private func setup() {
        interactor.presenter = presenter
        presenter.controller = self
        router.controller = self
    }
    
    private func setupLottie() {
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    public func displayScreenValue() {
        animationView.play()
    }
    
    public func navigateToLogin() {
        router.routeToLogin()
    }
    
    public func displayLoggedIn() {
        router.routeToLoggedIn()
    }
    
    public func displayHomeView() {
        router.routeHomeView()
    }
}


