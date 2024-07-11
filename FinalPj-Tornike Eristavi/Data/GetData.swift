//
//  GetData.swift
//  FinalPj-Tornike Eristavi
//
//  Created by Tornike Eristavi on 01.07.24.
import Foundation

class GetData {
    
    func fetchMovies(query: String, page: Int, completion: @escaping ([Movie]) -> Void) {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Invalid query")
            return
        }
        
        let urlString = "https://www.omdbapi.com/?apikey=5cfec60e&s=\(encodedQuery)&page=\(page)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(movieResponse.Search)
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }

    func fetchMovieDetails(for title: String, completion: @escaping (Movie?) -> Void) {
        guard let encodedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Invalid title")
            return
        }
        
        let urlString = "https://www.omdbapi.com/?apikey=5cfec60e&t=\(encodedTitle)"  
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movie = try decoder.decode(Movie.self, from: data)
                DispatchQueue.main.async {
                    completion(movie)
                }
            } catch {
                print("Error decoding data: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
