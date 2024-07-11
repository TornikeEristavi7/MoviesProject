//
//  File.swift
//  FinalPj-Tornike Eristavi
//
//  Created by Tornike Eristavi on 05.07.24.
//
import Foundation

enum APIClientError: Error {
    case invalidURL
    case noData
    case decodingError
}

class APIClient {
    static func fetchMovieDetails(for movieID: String, completion: @escaping (Result<Movie, APIClientError>) -> Void) {
        // Replace the URL string with your actual endpoint
        let urlString = "https://api.example.com/movies/\(movieID)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch movie details:", error)
                completion(.failure(.noData))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                completion(.success(movie))
            } catch {
                print("Failed to decode movie details:", error)
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
}
