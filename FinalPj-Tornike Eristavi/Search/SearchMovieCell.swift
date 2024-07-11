//
//  MovieTableViewCell.swift
//  FinalPj-Tornike Eristavi
//
//  Created by Tornike Eristavi on 05.07.24.
//
import UIKit

class SearchMovieCell: UITableViewCell {
    static let identifier = "SearchMovieCell"
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.tintColor = .orange
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genreIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "ticket.fill"))
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let yearIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "calendar"))
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let runtimeIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "clock.fill"))
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let runtimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingIconImageView)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(genreIconImageView)
        contentView.addSubview(genreLabel)
        contentView.addSubview(yearIconImageView)
        contentView.addSubview(yearLabel)
        contentView.addSubview(runtimeIconImageView)
        contentView.addSubview(runtimeLabel)
        
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            movieImageView.widthAnchor.constraint(equalToConstant: 95),
            movieImageView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            ratingIconImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingIconImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            ratingIconImageView.widthAnchor.constraint(equalToConstant: 16),
            ratingIconImageView.heightAnchor.constraint(equalToConstant: 16),
            
            ratingLabel.leadingAnchor.constraint(equalTo: ratingIconImageView.trailingAnchor, constant: 4),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingIconImageView.centerYAnchor),
            
            genreIconImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            genreIconImageView.topAnchor.constraint(equalTo: ratingIconImageView.bottomAnchor, constant: 8),
            genreIconImageView.widthAnchor.constraint(equalToConstant: 16),
            genreIconImageView.heightAnchor.constraint(equalToConstant: 16),
            
            genreLabel.leadingAnchor.constraint(equalTo: genreIconImageView.trailingAnchor, constant: 4),
            genreLabel.centerYAnchor.constraint(equalTo: genreIconImageView.centerYAnchor),
            
            yearIconImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            yearIconImageView.topAnchor.constraint(equalTo: genreIconImageView.bottomAnchor, constant: 8),
            yearIconImageView.widthAnchor.constraint(equalToConstant: 16),
            yearIconImageView.heightAnchor.constraint(equalToConstant: 16),
            
            yearLabel.leadingAnchor.constraint(equalTo: yearIconImageView.trailingAnchor, constant: 4),
            yearLabel.centerYAnchor.constraint(equalTo: yearIconImageView.centerYAnchor),
            
            runtimeIconImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            runtimeIconImageView.topAnchor.constraint(equalTo: yearIconImageView.bottomAnchor, constant: 8),
            runtimeIconImageView.widthAnchor.constraint(equalToConstant: 16),
            runtimeIconImageView.heightAnchor.constraint(equalToConstant: 16),
            
            runtimeLabel.leadingAnchor.constraint(equalTo: runtimeIconImageView.trailingAnchor, constant: 4),
            runtimeLabel.centerYAnchor.constraint(equalTo: runtimeIconImageView.centerYAnchor),
            runtimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init code erorr")
    }
    
    public func configure(with movie: Movie) {
        print("Configuring cell with movie: \(movie)")
        titleLabel.text = movie.Title
        ratingLabel.text = movie.rating
        genreLabel.text = movie.Genre
        yearLabel.text = movie.Year
        runtimeLabel.text = movie.Runtime
        
        if let posterUrl = movie.Poster, let url = URL(string: posterUrl) {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.movieImageView.image = image
                    }
                } else {
                    print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                }
            }.resume()
        } else {
            print("Invalid poster URL.")
        }
    }
}

