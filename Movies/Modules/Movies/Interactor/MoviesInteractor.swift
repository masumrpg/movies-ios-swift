//
//  MoviesInteractor.swift
//  Movies
//
//  Created by Ma'sum on 31/12/24.
//

import Foundation

class MoviesInteractor: ObservableObject {

    @Published var movies: [Movie] = []
    
    private let apiKey: String
    private let baseUrl: String
    private let genreId: Int
    
    init(baseUrl: String, apiKey: String, genreId: Int) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
        self.genreId = genreId
    }

    func loadTrending() {
        Task {
            let url = URL(string: "\(baseUrl)/discover/movie?with_genres=\(genreId)&page=1&api_key=\(apiKey)")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let movies = try JSONDecoder().decode(MoviesPageResponse.self, from: data)
           
                                DispatchQueue.main.async {
                                    self.movies = movies.results
                                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
