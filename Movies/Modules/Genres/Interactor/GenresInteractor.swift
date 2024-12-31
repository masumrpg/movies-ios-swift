//
//  GenresInteractor.swift
//  Movies
//
//  Created by Ma'sum on 31/12/24.
//

import Foundation

class GenresInteractor: ObservableObject {
    @Published var genres: [Genre] = []
    
    private let apiKey: String
    private let baseUrl: String
    
    init(baseUrl: String, apiKey: String) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
    }
    
    func loadGenres() {
        let urlString = "\(baseUrl)/genre/movie/list?api_key=\(apiKey)&language=en-US"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedResponse = try JSONDecoder().decode([String: [Genre]].self, from: data)
                genres = decodedResponse["genres"] ?? []
            } catch {
                print("Error fetching genres: \(error)")
            }
        }
    }
    
    func findGenreById(genreId: Int, genres: [Genre]) -> String? {
        if let genre = genres.first(where: { $0.id == genreId }) {
            return genre.name
        }
        return nil
    }
}
