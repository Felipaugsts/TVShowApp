//
//  MovieDetailsViewController.swift
//  MinhasDespesas
//
//  Created by Felipe Augusto Silva on 23/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit
import SnapKit
import SDWebImage
import SDKCommon

// MARK: - IMovieDetailsViewController

protocol MovieDetailsViewControllerProtocol: AnyObject {
    func displayScreenValues(_ values: MovieDetailsModel.ScreenValues)
}

// MARK: - MovieDetailsViewController

class MovieDetailsViewController: UIViewController {
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .circularBook(size: 14)
        label.textColor = DSColor.medium
        label.lineBreakMode = .byWordWrapping // Set the line break mode to word wrap
        label.numberOfLines = 0 // Set the number of lines to 0 for unlimited lines
        label.backgroundColor = DSColor.black
        label.layer.opacity = 0.95
        return label
    }()
    
    var informationView: UIView = {
        let view = UIView()
        view.backgroundColor = DSColor.black
        view.layer.opacity = 0.95
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .circularBold(size: 18)
        label.textColor = DSColor.lightest
        label.backgroundColor = DSColor.black
        label.layer.opacity = 0.95
        return label
    }()
    
    lazy var descriptionView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 150))
        view.translatesAutoresizingMaskIntoConstraints = false
        let gradient = CAGradientLayer()

        gradient.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
        gradient.colors = [UIColor.clear.cgColor, DSColor.black.cgColor] // Reversed order of colors
        gradient.opacity = 0.95
        view.layer.insertSublayer(gradient, at: 0)
        return view
    }()

    var likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.layer.cornerRadius = button.frame.size.width / 2
        button.backgroundColor = UIColor.clear
        button.translatesAutoresizingMaskIntoConstraints = false
        let heartImage = UIImage(systemName: "heart")
        button.setImage(heartImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.white // Set the icon color to white
        return button
    }()
    
    var interactor: (MovieDetailsInteractorProtocol & MoviesDataStore)
    var presenter: MovieDetailsPresenterProtocol
    var router: (NSObjectProtocol & MovieDetailsRouterProtocol & HomeRouterDataPassing)
    
    init(interactor: (MovieDetailsInteractorProtocol & MoviesDataStore) = MovieDetailsInteractor(),
         presenter: MovieDetailsPresenterProtocol = MovieDetailsPresenter(),
         router: (NSObjectProtocol & MovieDetailsRouterProtocol & HomeRouterDataPassing) = MovieDetailsRouter()) {
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
        setupLayout()
    }
    
    private func setup() {
        interactor.presenter = presenter
        presenter.controller = self
        router.controller = self
        router.dataStore = interactor
    }
    
    private func setupLayout() {
        view.addSubview(imageView)
        view.addSubview(descriptionView)
        descriptionView.addSubview(informationView)
        informationView.addSubview(descriptionLabel)
        informationView.addSubview(titleLabel)
        informationView.addSubview(likeButton)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(view.frame.height - 200)
        }
        
        descriptionView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(-350)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(350)
        }
        
        informationView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.right.equalTo(likeButton.snp.left)
            make.height.equalTo(50)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(titleLabel.snp.right)
            make.right.equalToSuperview().offset(-30)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-30)
            make.left.equalToSuperview().offset(30)
        }
    }
}

// MARK: MovieDetailsViewControllerProtocol Implementation

extension MovieDetailsViewController: MovieDetailsViewControllerProtocol {
    
    func displayScreenValues(_ values: MovieDetailsModel.ScreenValues) {
        view.backgroundColor = DSColor.black
        var urlString = ""
        if let posterPath = values.movie?.posterPath {
            urlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
        }
        
        imageView.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "placeholderImage"))
        descriptionLabel.text = values.movie?.overview
        titleLabel.text = values.movie?.title
    }
}

extension UIView {
    func addGradientOverlay(frame: CGRect, startColor: UIColor, endColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        self.layer.addSublayer(gradientLayer)
    }
}
