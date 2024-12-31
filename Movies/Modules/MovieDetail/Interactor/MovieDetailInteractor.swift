//
//  MovieDetailInteractor.swift
//  Movies
//
//  Created by Ma'sum on 01/01/25.
//

import Foundation

class MoviesDetailInteractor: ObservableObject {
    @Published var movieDetail: MovieDetail?
    @Published var error: String?
    
    private let baseUrl: String
    private let apiKey: String

    init(baseUrl: String, apiKey: String) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
    }
    
    // Fungsi asinkron untuk memuat detail film
    func loadMovieDetail(movieId: Int) {
        Task {
            let urlString = "\(baseUrl)/movie/\(movieId)?api_key=\(apiKey)"
            
            guard let url = URL(string: urlString) else {
                self.error = "Invalid URL"
                return
            }
            
            do {
                // Ambil data dari API
                let (data, _) = try await URLSession.shared.data(from: url)
                
                // Decode data menjadi model MovieDetail
                let decoder = JSONDecoder()
                self.movieDetail = try decoder.decode(MovieDetail.self, from: data)
            } catch {
                // Tangani kesalahan jika terjadi saat pengambilan data atau decoding
                self.error = "Error: \(error.localizedDescription)"
            }
        }
    }
}
