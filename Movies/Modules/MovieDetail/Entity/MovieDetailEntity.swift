//
//  MovieDetailEntity.swift
//  Movies
//
//  Created by Ma'sum on 01/01/25.
//

import Foundation


struct MovieDetail: Decodable {
    let id: Int
    let title: String
    let backdropPath: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    let voteAverage: Double
    let genres: [Genre]
    let video: Bool
    let imdbId: String
    let videoUrl: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case backdropPath = "backdrop_path"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case genres
        case video
        case imdbId = "imdb_id" 
        case videoUrl = "video_url"
    }
    
    var backdropURL: URL? {
           let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")
           return baseURL?.appending(path: backdropPath)
       }
}

struct CastProfile: Decodable, Identifiable {

    let birthday: String?
    let id: Int
    let name: String
    let profile_path: String?

    var photoUrl: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w200")
        return baseURL?.appending(path: profile_path ?? "")
    }
}

struct MovieCredits: Decodable {

    let id: Int
    let cast: [Cast]

    struct Cast: Decodable, Identifiable {
        let name: String
        let id: Int
        let character: String
        let order: Int
    }
}
