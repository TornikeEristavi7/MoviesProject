//
//  HomeViewController.swift
//  FinalPj-Tornike Eristavi
//
//  Created by Tornike Eristavi on 01.07.24.
import UIKit

class HomeViewController: UIViewController {
    
    var movies: [Movie] = []
    private var filteredMovies: [Movie] = []
    private var collectionView: UICollectionView!
    private let movieService = GetData()
    private var currentPage = 1
    private var isFetching = false
    private let query = "Avengers"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchMovies()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor(white: 0.1, alpha: 1.0)
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
    }

    private func setupViews() {
        let titleLabel = UILabel()
        titleLabel.text = "Movies"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 30.0, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let containerView = UIView()
        containerView.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14).isActive = true
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        containerView.widthAnchor.constraint(equalToConstant: 343).isActive = true
        containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 41).isActive = true
        
        navigationItem.titleView = containerView
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        
        let itemWidth = (view.frame.width - layout.sectionInset.left - layout.sectionInset.right - layout.minimumInteritemSpacing * 2) / 3
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.8)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(white: 0.1, alpha: 1.0) 
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

      
        collectionView.addInfiniteScroll { [weak self] collectionView in
            self?.fetchMoreMovies()
        }
    }

    private func fetchMovies() {
        guard !isFetching else { return }
        isFetching = true
        movieService.fetchMovies(query: query, page: currentPage) { [weak self] movies in
            guard let self = self else { return }
            self.movies = movies
            self.filteredMovies = movies
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.isFetching = false
            }
        }
    }

    private func fetchMoreMovies() {
        guard !isFetching else { return }
        isFetching = true
        currentPage += 1
        movieService.fetchMovies(query: query, page: currentPage) { [weak self] movies in
            guard let self = self else { return }
            self.movies.append(contentsOf: movies)
            self.filteredMovies = self.movies
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.finishInfiniteScroll()
                self.isFetching = false
            }
        }
    }

    func filterMovies(with searchText: String) {
        if searchText.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter { $0.Title?.lowercased().contains(searchText.lowercased()) ?? false }
        }
        collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = filteredMovies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = filteredMovies[indexPath.item]
        let detailVC = MovieDetailViewController()
        detailVC.movieID = selectedMovie.id
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
