//
//  HomeViewController.swift
//  MinhasDespesas
//
//  Created by Felipe Augusto Silva on 13/10/23.
//  Copyright (c) 2023 Stockbit - ARI MUNANDAR. All rights reserved.

import UIKit
import SnapKit
import SDKCommon
import SDWebImage

// MARK: - Protocol

protocol HomeViewControllerProtocol: AnyObject {
    func displayScreenValues(_ values: HomeModel.ScreenValues)
    func displayPopulars(movies: [Movie])
    func displayMovieSelected()
}

// MARK: - HomeViewController

class HomeViewController: UIViewController {

    // MARK: - Components
    
    lazy var safeArea = view.safeAreaLayoutGuide
    
    let background: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "backgroundHome")
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .white
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.reusableIdentifier)
        collection.isUserInteractionEnabled = true
        return collection
    }()
    
    lazy var labelCollection: UILabel = {
        let label = UILabel()
        label.text = "Olá, Felipe"
        label.font = UIFont.circularBook(size: 16)
        label.textColor = DSColor.light
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var newsLabel: UILabel = {
        let label = UILabel()
        label.text = "Veja o que está em alta."
        label.font = UIFont.circularBook(size: 14)
        label.textColor = DSColor.dark
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 50, y: 50, width: 50, height: 50) // Set the frame as per your requirements
        imageView.contentMode = .scaleAspectFill // Adjust the content mode as needed
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let avatarImage = UIImage(named: "felipe") {
            imageView.image = avatarImage
            imageView.layer.cornerRadius = 50 / 2
            imageView.clipsToBounds = true
        }

        return imageView
    }()
    
    // MARK: - Arch Variables
    
    var interactor: (HomeInteractorProtocol & MoviesDataStore)
    var presenter: HomePresenterProtocol
    var router: (NSObjectProtocol & HomeRouterProtocol & HomeRouterDataPassing)
    
    private var popularMovies: [Movie] = []
    
    // MARK: - Initializers
    
    init(interactor: (HomeInteractorProtocol & MoviesDataStore) = HomeInteractor(),
         presenter: HomePresenterProtocol = HomePresenter(),
         router: (NSObjectProtocol & HomeRouterProtocol & HomeRouterDataPassing) = HomeRouter()) {
        self.interactor = interactor
        self.presenter = presenter
        self.router = router
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadScreenValues()
        setupLayout()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        interactor.presenter = presenter
        presenter.controller = self
        router.controller = self
        router.dataStore = interactor
    }
    
    private func setupLayout() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        searchButton.tintColor = .white
        navigationItem.rightBarButtonItem = searchButton
        
        view.addSubview(background)
        view.addSubview(collectionView)
        view.addSubview(labelCollection)
        view.addSubview(newsLabel)
        view.addSubview(imageAvatar)
        
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        labelCollection.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(imageAvatar.snp.left)
        }

        newsLabel.snp.makeConstraints { make in
            make.top.equalTo(labelCollection.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(imageAvatar.snp.left)
        }

        imageAvatar.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.left.equalTo(labelCollection.snp.right)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(safeArea.snp.top).offset(30)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(newsLabel.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(300)
        }
    }
    
    @objc
    func searchTapped() {
        let newViewController = MovieDetailsViewController()
        navigationController?.present(newViewController, animated: true)
     }
}

// MARK: Protocol Implementation

extension HomeViewController: HomeViewControllerProtocol {
    func displayScreenValues(_ values: HomeModel.ScreenValues) {
       
    }
    
    func displayPopulars(movies: [Movie]) {
        popularMovies = movies
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func displayMovieSelected() {
        router.routeToMovieSelected()
    }
}

// MARK: - Popular Movie

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMovies.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 300)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.reusableIdentifier, for: indexPath) as! CustomCollectionViewCell

        let movie = popularMovies[indexPath.row]
        // Configure the cell with your data
        var urlString: String = ""
        
        if let posterPath = movie.posterPath {
            urlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
        }
        
        let imageURL = URL(string: urlString)

        cell.configure(with: imageURL, title: movie.title ?? "te")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieSelected = popularMovies[indexPath.row]
        interactor.didSelectMovie(movieSelected)
    }
}
