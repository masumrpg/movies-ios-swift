//
//  MoviesEntity.swift
//  Movies
//
//  Created by Ma'sum on 31/12/24.
//

import Foundation

struct Movie: Identifiable, Decodable, Equatable {
    let id: Int
    let adult: Bool
    let poster_path: String?
    let title: String
    let overview: String
    let vote_average: Float
    let backdrop_path: String?

    var backdropURL: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")
        return baseURL?.appending(path: backdrop_path ?? "")
    }

    var posterThumbnail: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w100")
        return baseURL?.appending(path: poster_path ?? "")
    }

    var poster: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")
        return baseURL?.appending(path: poster_path ?? "")
    }

    static var preview: Movie {
        return Movie(
                    id: 23834,
                    adult: false,
                     poster_path: "https://image.tmdb.org/t/p/w300",
                     title: "Free Guy",
                     overview: "some demo text here",
                     vote_average: 5.5,
                     backdrop_path: "https://image.tmdb.org/t/p/w300")
    }
}

struct MoviesPage: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
