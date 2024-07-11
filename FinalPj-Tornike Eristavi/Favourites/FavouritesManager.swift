//
//  FavouritesManager.swift
//  FinalPj-Tornike Eristavi
//
//  Created by Tornike Eristavi on 01.07.24.
//
import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    
    private var favoriteMovies: [Movie] = []
    
    private init() {
    }
    
    func getFavorites() -> [Movie] {
        return favoriteMovies
    }
    
    func addFavorite(_ movie: Movie) {
        if !isFavorite(movie) {
            favoriteMovies.append(movie)
        }
    }
    
    func removeFavorite(_ movie: Movie) {
        favoriteMovies.removeAll { $0.id == movie.id }
    }
    
    func isFavorite(_ movie: Movie) -> Bool {
        return favoriteMovies.contains(where: { $0.id == movie.id })
    }
}
