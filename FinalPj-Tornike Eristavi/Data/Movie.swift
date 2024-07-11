//
//  struct.swift
//  FinalPj-Tornike Eristavi
//
//  Created by Tornike Eristavi on 05.07.24.
//

import Foundation

public struct Movie: Codable {
    public let id: String
    public var Title: String?
    public var Year: String?
    public var Runtime: String?
    public var Genre: String?
    public var Value: Int?
    public var Poster: String?
    public var Plot: String?
    public var rating: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "imdbID"
        case Title
        case Year
        case Runtime
        case Genre
        case Value
        case Poster
        case Plot
        case rating = "imdbRating"
    }
}

public struct MovieResponse: Codable {
    public let Search: [Movie]
}
