//
//  MovieDetailsViewController.swift
//  MinhasDespesas
//
//  Created by Felipe Augusto Silva on 23/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit

// MARK: - IMovieDetailsViewController

protocol MovieDetailsViewControllerProtocol: AnyObject {
    func displayScreenValues(_ values: MovieDetailsModel.ScreenValues)
}

// MARK: - MovieDetailsViewController

class MovieDetailsViewController: UIViewController {
    
    var interactor: MovieDetailsInteractorProtocol
    var presenter: MovieDetailsPresenterProtocol
    var router: MovieDetailsRouterProtocol
    
    let movieImage: UIImageView = {
        let imageview = UIImageView()
        let image = UIImage(named: "")
        imageview.image = image
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    init(interactor: MovieDetailsInteractorProtocol = MovieDetailsInteractor(),
         presenter: MovieDetailsPresenterProtocol = MovieDetailsPresenter(),
         router: MovieDetailsRouterProtocol = MovieDetailsRouter()) {
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
        
        view.addSubview(movieImage)
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: view.topAnchor),
            movieImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            movieImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: view.frame.height / 2)
        ])
    }
    
    private func setup() {
        interactor.presenter = presenter
        presenter.controller = self
        router.controller = self
    }
}

// MARK: MovieDetailsViewControllerProtocol Implementation

extension MovieDetailsViewController: MovieDetailsViewControllerProtocol {
    
    func displayScreenValues(_ values: MovieDetailsModel.ScreenValues) {
        view.backgroundColor = .red
    }
}
