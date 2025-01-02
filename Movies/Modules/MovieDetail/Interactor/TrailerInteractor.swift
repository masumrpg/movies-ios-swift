//
//  MovieTrailerInteractor.swift
//  Movies
//
//  Created by Ma'sum on 01/01/25.
//

import Foundation

protocol TrailerInteractorProtocol {
    func fetchTrailers(completion: @escaping (Result<[Trailer], Error>) -> Void)
}

class TrailerInteractor: ObservableObject {
    @Published var trailer: TrailerResponse?
    @Published var error: String?
    
    private let baseUrl: String
    private let apiKey: String

    init(baseUrl: String, apiKey: String) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
    }
    
    
    func loadMovieDetail(movieId: Int) {
        Task {
            let urlString = "\(baseUrl)/movie/\(movieId)/videos?api_key=\(apiKey)"
            
            guard let url = URL(string: urlString) else {
                self.error = "Invalid URL"
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let decoder = JSONDecoder()
                self.trailer = try decoder.decode(TrailerResponse.self, from: data)
            } catch {
                self.error = "Error: \(error.localizedDescription)"
            }
        }
    }
}
