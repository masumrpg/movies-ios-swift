//
//  MoviesInteractor.swift
//  Movies
//
//  Created by Ma'sum on 31/12/24.
//

import Foundation

class MoviesInteractor: ObservableObject {

    @Published var moviesPage: MoviesPage = MoviesPage(
        page: 1,
        results: [],
        totalPages: 0,
        totalResults: 0
    )
    @Published var movies: [Movie] = []
    
    private let apiKey: String
    private let baseUrl: String
    private let genreId: Int
    var currentPage: Int = 1
    
    init(baseUrl: String, apiKey: String, genreId: Int) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
        self.genreId = genreId
    }

    func loadMovies() {
        Task {
            let url = URL(string: "\(baseUrl)/discover/movie?with_genres=\(genreId)&page=\(currentPage)&api_key=\(apiKey)")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let movies = try JSONDecoder().decode(MoviesPage.self, from: data)
                
                DispatchQueue.main.async {
                    self.moviesPage = movies
                    self.movies = movies.results
                }
                
                currentPage += 1
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func loadNextPage(completion: @escaping () -> Void) {
        guard currentPage <= moviesPage.totalPages else {
            completion()
            return
        }
        
        Task {
            let url = URL(string: "\(baseUrl)/discover/movie?with_genres=\(genreId)&page=\(currentPage + 1)&api_key=\(apiKey)")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let movies = try JSONDecoder().decode(MoviesPage.self, from: data)
                
                DispatchQueue.main.async {
                    self.moviesPage = movies
                    self.movies.append(contentsOf: movies.results)
                    self.currentPage += 1
                }
                
                completion()
            } catch {
                print(error.localizedDescription)
                completion()
            }
        }
    }
}
