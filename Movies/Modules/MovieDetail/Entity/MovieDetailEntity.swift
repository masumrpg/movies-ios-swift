//
//  MovieDetailEntity.swift
//  Movies
//
//  Created by Ma'sum on 01/01/25.
//

import Foundation


struct MovieDetail: Decodable {
    let title: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    let voteAverage: Double
    let genres: [Genre]
    let video: Bool
    let imdbId: String
    let videoUrl: String?

    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case genres
        case video
        case imdbId = "imdb_id" 
        case videoUrl = "video_url"
    }
}
