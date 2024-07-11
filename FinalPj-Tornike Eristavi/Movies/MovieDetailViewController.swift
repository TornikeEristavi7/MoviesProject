//
//  MovieDetailViewController.swift
//  FinalPj-Tornike Eristavi
//
//  Created by Tornike Eristavi on 01.07.24.
//
import UIKit

class MovieDetailViewController: UIViewController {
    
    var movieID: String?
    private var movie: Movie?
    private var isFavorite = false
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let smallImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 14
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1.5
        return imageView
    }()
    
    private let topTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieDetailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 0.8, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 0.8, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let aboutMovieView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        view.layer.cornerRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let aboutMovieLabel: UILabel = {
        let label = UILabel()
        label.text = "About Movie"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let ratingContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.7)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let ratingStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .orange
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        setupViews()
        fetchMovieDetails()
        
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        updateFavoriteButton()
    }
    
    private func setupViews() {
        view.addSubview(imageView)
        view.addSubview(smallImageView)
        view.addSubview(topTitleLabel)
        view.addSubview(movieDetailLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(aboutMovieView)
        aboutMovieView.addSubview(aboutMovieLabel)
        aboutMovieView.addSubview(favoriteButton)
        aboutMovieView.addSubview(separatorLine)
        view.addSubview(ratingContainerView)
        ratingContainerView.addSubview(ratingStarImageView)
        ratingContainerView.addSubview(ratingLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            smallImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            smallImageView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -40),
            smallImageView.widthAnchor.constraint(equalToConstant: 80),
            smallImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            topTitleLabel.leadingAnchor.constraint(equalTo: smallImageView.trailingAnchor, constant: 8),
            topTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            topTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            topTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])
        
        NSLayoutConstraint.activate([
            movieDetailLabel.topAnchor.constraint(equalTo: smallImageView.bottomAnchor, constant: 20),
            movieDetailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            movieDetailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14)
        ])
        
        NSLayoutConstraint.activate([
            aboutMovieView.topAnchor.constraint(equalTo: movieDetailLabel.bottomAnchor, constant: 40),
            aboutMovieView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            aboutMovieView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            aboutMovieView.heightAnchor.constraint(equalToConstant: 35),
            
            aboutMovieLabel.leadingAnchor.constraint(equalTo: aboutMovieView.leadingAnchor, constant: 14),
            aboutMovieLabel.centerYAnchor.constraint(equalTo: aboutMovieView.centerYAnchor),
            
            favoriteButton.trailingAnchor.constraint(equalTo: aboutMovieView.trailingAnchor, constant: -14),
            favoriteButton.centerYAnchor.constraint(equalTo: aboutMovieView.centerYAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 20),
            favoriteButton.heightAnchor.constraint(equalToConstant: 20),
            
            separatorLine.topAnchor.constraint(equalTo: aboutMovieLabel.bottomAnchor, constant: 6),
            separatorLine.leadingAnchor.constraint(equalTo: aboutMovieView.leadingAnchor, constant: 14),
            separatorLine.trailingAnchor.constraint(equalTo: aboutMovieView.trailingAnchor, constant: -14),
            separatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            descriptionLabel.topAnchor.constraint(equalTo: aboutMovieView.bottomAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -14)
        ])
        
        NSLayoutConstraint.activate([
            ratingContainerView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -6),
            ratingContainerView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -30),
            ratingContainerView.heightAnchor.constraint(equalToConstant: 30),
            ratingContainerView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            ratingStarImageView.leadingAnchor.constraint(equalTo: ratingContainerView.leadingAnchor, constant: 4),
            ratingStarImageView.centerYAnchor.constraint(equalTo: ratingContainerView.centerYAnchor),
            ratingStarImageView.widthAnchor.constraint(equalToConstant: 20),
            ratingStarImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            ratingLabel.leadingAnchor.constraint(equalTo: ratingStarImageView.trailingAnchor, constant: 2),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingStarImageView.centerYAnchor)
        ])
    }
    
    private func fetchMovieDetails() {
        guard let movieID = movieID else { return }
        let urlString = "https://www.omdbapi.com/?apikey=5cfec60e&i=\(movieID)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching movie details: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movie = try decoder.decode(Movie.self, from: data)
                self?.movie = movie
                self?.isFavorite = FavoritesManager.shared.isFavorite(movie)
                DispatchQueue.main.async {
                    self?.displayMovieDetails()
                }
            } catch {
                print("Error decoding movie details: \(error)")
            }
        }.resume()
    }
    
    private func displayMovieDetails() {
        guard let movie = movie else { return }
        topTitleLabel.text = movie.Title ?? "No Title"
        
        let movieDetails = NSMutableAttributedString()
        let textColor = UIColor.white
        
        if let year = movie.Year {
            let calendarIcon = NSTextAttachment()
            calendarIcon.image = UIImage(systemName: "calendar")?.withTintColor(textColor)
            let calendarIconString = NSAttributedString(attachment: calendarIcon)
            movieDetails.append(calendarIconString)
            movieDetails.append(NSAttributedString(string: " \(year) | "))
        }
        if let runtime = movie.Runtime {
            let clockIcon = NSTextAttachment()
            clockIcon.image = UIImage(systemName: "clock")?.withTintColor(textColor)
            let clockIconString = NSAttributedString(attachment: clockIcon)
            movieDetails.append(clockIconString)
            movieDetails.append(NSAttributedString(string: " \(runtime) | "))
        }
        if let genre = movie.Genre {
            let ticketIcon = NSTextAttachment()
            ticketIcon.image = UIImage(systemName: "ticket")?.withTintColor(textColor)
            let ticketIconString = NSAttributedString(attachment: ticketIcon)
            movieDetails.append(ticketIconString)
            movieDetails.append(NSAttributedString(string: " \(genre)"))
        }
        movieDetailLabel.attributedText = movieDetails
        descriptionLabel.text = movie.Plot ?? "No plot available."
        
        if let posterUrl = movie.Poster, let url = URL(string: posterUrl) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let error = error {
                    print("Failed to fetch image data: \(error)")
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                        self?.smallImageView.image = image
                        self?.imageView.alpha = 1
                        self?.smallImageView.alpha = 1
                    }
                }
            }.resume()
        }
        if let rating = movie.rating {
            ratingLabel.text = "\(rating)"
        } else {
            ratingLabel.text = "N/A"
        }
        
        updateFavoriteButton()
    }
    
    private func updateFavoriteButton() {
        if isFavorite {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteButton.tintColor = .red
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favoriteButton.tintColor = .white
        }
    }
    
    @objc private func toggleFavorite() {
        guard let movie = movie else { return }
        if isFavorite {
            FavoritesManager.shared.removeFavorite(movie)
        } else {
            FavoritesManager.shared.addFavorite(movie)
        }
        
        isFavorite = !isFavorite
        updateFavoriteButton()
    }
}
