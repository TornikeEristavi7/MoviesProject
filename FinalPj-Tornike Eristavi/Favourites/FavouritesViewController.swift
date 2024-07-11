//
//  FavouritesViewController.swift
//  FinalPj-Tornike Eristavi
//
//  Created by Tornike Eristavi on 01.07.24.
//
import UIKit

class FavouritesViewController: UIViewController {
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var favoriteMovies: [Movie] = []
    
    private let noFavoritesLabel: UILabel = {
        let label = UILabel()
        label.text = "No Favourites Yet"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "All movies marked as favourite will be added here"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        
        let titleLabel = UILabel()
        titleLabel.text = "Favourites"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 30.0, weight: .bold)
        titleLabel.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        
        setupCollectionView()
        setupNoFavoritesLabel()
        setupInfoLabel()
        loadFavorites()
    }
    
    private func setupCollectionView() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 16
            layout.minimumInteritemSpacing = 16
            layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            let itemWidth = (view.frame.width - 64) / 3
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.8)
        }
        
        collectionView.frame = view.bounds
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FavoriteMovieCell.self, forCellWithReuseIdentifier: FavoriteMovieCell.reuseIdentifier)
        view.addSubview(collectionView)
    }
    
    private func setupNoFavoritesLabel() {
        view.addSubview(noFavoritesLabel)
        
        NSLayoutConstraint.activate([
            noFavoritesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noFavoritesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20)
        ])
    }
    
    private func setupInfoLabel() {
        view.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: noFavoritesLabel.bottomAnchor, constant: 10),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    
    private func loadFavorites() {
        favoriteMovies = FavoritesManager.shared.getFavorites()
        collectionView.reloadData()
        updateNoFavoritesLabel()
    }
    
    private func updateNoFavoritesLabel() {
        noFavoritesLabel.isHidden = !favoriteMovies.isEmpty
        infoLabel.isHidden = !favoriteMovies.isEmpty
    }
}

extension FavouritesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteMovieCell.reuseIdentifier, for: indexPath) as! FavoriteMovieCell
        let movie = favoriteMovies[indexPath.item]
        cell.configure(with: movie)
        
        cell.favoriteButtonTapped = { [weak self] in
            self?.handleFavoriteButtonTap(for: movie)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = favoriteMovies[indexPath.item]
        let movieDetailVC = MovieDetailViewController()
        movieDetailVC.movieID = movie.id
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    private func handleFavoriteButtonTap(for movie: Movie) {
        if FavoritesManager.shared.isFavorite(movie) {
            FavoritesManager.shared.removeFavorite(movie)
        } else {
            FavoritesManager.shared.addFavorite(movie)
        }
        
        loadFavorites()
    }
}
