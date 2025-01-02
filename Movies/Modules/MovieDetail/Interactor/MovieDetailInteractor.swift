//
//  MovieDetailInteractor.swift
//  Movies
//
//  Created by Ma'sum on 01/01/25.
//

import Foundation

class MoviesDetailInteractor: ObservableObject {
    @Published var movieDetail: MovieDetail?
    @Published var credits: MovieCredits?
        @Published var cast: [MovieCredits.Cast] = []
        @Published var castProfiles: [CastProfile] = []
    @Published var error: String?
    
    private let baseUrl: String
    private let apiKey: String

    init(baseUrl: String, apiKey: String) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
    }
    
    
    func loadMovieDetail(movieId: Int) {
        Task {
            let urlString = "\(baseUrl)/movie/\(movieId)?api_key=\(apiKey)"
            
            guard let url = URL(string: urlString) else {
                self.error = "Invalid URL"
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let decoder = JSONDecoder()
                self.movieDetail = try decoder.decode(MovieDetail.self, from: data)
            } catch {
                self.error = "Error: \(error.localizedDescription)"
            }
        }
    }
    
    func movieCredits(for movieId: Int) async {
            let url = URL(string: "\(baseUrl)/movie/\(movieId)/credits?api_key=\(apiKey)&language=en-US")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let credits = try JSONDecoder().decode(MovieCredits.self, from: data)
                self.credits = credits
                self.cast = credits.cast.sorted(by: { $0.order < $1.order })
            } catch {
                print(error.localizedDescription)
            }
        }

        func loadCastProfiles() async {
            do {
                for member in cast {
                    let url = URL(string: "\(baseUrl)/person/\(member.id)?api_key=\(apiKey)&language=en-US")!
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let profile = try JSONDecoder().decode(CastProfile.self, from: data)
                    castProfiles.append(profile)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
}
