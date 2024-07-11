//
//  SearchVC.swift
//  FinalPj-Tornike Eristavi
//
//  Created by Tornike Eristavi on 01.07.24.
//
import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private var filteredMovies: [Movie] = []
    private let movieService = GetData()
    private let noResultsLabel = UILabel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        
        let titleLabel = UILabel()
        titleLabel.text = "Search"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 30.0, weight: .bold)
        titleLabel.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        
        setupSearchBar()
        setupTableView()
        setupNoResultsLabel()
    }
    
    private func setupSearchBar() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showSortOptions), for: .touchUpInside)
        
        searchBar.placeholder = "Search for movies"
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundImage = UIImage()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.layer.cornerRadius = 16
        searchBar.layer.masksToBounds = true
        searchBar.layer.borderColor = UIColor(red: 0.404, green: 0.404, blue: 0.427, alpha: 1.0).cgColor
        searchBar.layer.borderWidth = 2.0
        searchBar.tintColor = .white
        searchBar.barTintColor = UIColor(white: 0.2, alpha: 1.0)
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .white
            textField.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
            textField.attributedPlaceholder = NSAttributedString(string: "Search for movies", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            
            let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
            searchIcon.tintColor = .lightGray
            textField.leftView = searchIcon
            textField.leftViewMode = .always
        }
        
        let searchContainerView = UIView()
        searchContainerView.translatesAutoresizingMaskIntoConstraints = false
        searchContainerView.addSubview(searchBar)
        searchContainerView.addSubview(button)
        
        view.addSubview(searchContainerView)
        
        NSLayoutConstraint.activate([
            searchContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            searchContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            searchContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchContainerView.heightAnchor.constraint(equalToConstant: 42),
            
            searchBar.leadingAnchor.constraint(equalTo: searchContainerView.leadingAnchor),
            searchBar.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor),
            searchBar.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 42),
            
            button.trailingAnchor.constraint(equalTo: searchContainerView.trailingAnchor),
            button.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 42),
            button.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    private func setupNoResultsLabel() {
        noResultsLabel.text = "Oh No Isn't This So Embarrassing?\nI cannot find any movie with this name."
        noResultsLabel.textColor = .white
        noResultsLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        noResultsLabel.numberOfLines = 0
        noResultsLabel.textAlignment = .center
        noResultsLabel.translatesAutoresizingMaskIntoConstraints = false
        noResultsLabel.isHidden = true
        
        view.addSubview(noResultsLabel)
        
        NSLayoutConstraint.activate([
            noResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noResultsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noResultsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func showSortOptions() {
        let alertController = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)
        
        let sortByNameAction = UIAlertAction(title: "Name", style: .default) { _ in
            self.sortMovies(by: .name)
        }
        let sortByGenreAction = UIAlertAction(title: "Genre", style: .default) { _ in
            self.sortMovies(by: .genre)
        }
        let sortByYearAction = UIAlertAction(title: "Year", style: .default) { _ in
            self.sortMovies(by: .year)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(sortByNameAction)
        alertController.addAction(sortByGenreAction)
        alertController.addAction(sortByYearAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func sortMovies(by criterion: SortCriterion) {
        switch criterion {
        case .name:
            filteredMovies.sort { $0.Title ?? "" < $1.Title ?? "" }
        case .genre:
            filteredMovies.sort { $0.Genre ?? "" < $1.Genre ?? "" }
        case .year:
            filteredMovies.sort { $0.Year ?? "" < $1.Year ?? "" }
        }
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchMovieCell.self, forCellReuseIdentifier: SearchMovieCell.identifier)
        tableView.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        tableView.contentInset = .zero
        tableView.scrollIndicatorInsets = .zero
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterMovies(with: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchMovies(for: searchBar.text)
    }
    
    private func filterMovies(with searchText: String) {
        if searchText.isEmpty {
            filteredMovies = []
            noResultsLabel.isHidden = false
            tableView.reloadData()
        } else {
            fetchMovies(for: searchText)
        }
    }
    
    private func fetchMovies(for query: String?) {
        guard let searchText = query, !searchText.isEmpty else {
            filteredMovies = []
            noResultsLabel.isHidden = false
            tableView.reloadData()
            return
        }
        
        movieService.fetchMovies(query: searchText, page: 1) { [weak self] movies in
            guard let self = self else { return }
            self.filteredMovies = movies
            self.fetchRatingsForMovies(movies)
            self.noResultsLabel.isHidden = !movies.isEmpty
        }
    }
    
    private func fetchRatingsForMovies(_ movies: [Movie]) {
        let group = DispatchGroup()
        for movie in movies {
            group.enter()
            movieService.fetchMovieDetails(for: movie.Title ?? "") { detailedMovie in
                if let index = self.filteredMovies.firstIndex(where: { $0.id == movie.id }) {
                    if let rating = detailedMovie?.rating {
                        self.filteredMovies[index].rating = rating
                    }
                    if let genre = detailedMovie?.Genre {
                        self.filteredMovies[index].Genre = genre
                    }
                    if let runtime = detailedMovie?.Runtime {
                        self.filteredMovies[index].Runtime = runtime
                    }
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:SearchMovieCell.identifier, for: indexPath) as! SearchMovieCell
        let movie = filteredMovies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = filteredMovies[indexPath.row]
        let detailVC = MovieDetailViewController()
        detailVC.movieID = selectedMovie.id
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

enum SortCriterion {
case name
case genre
case year
}
