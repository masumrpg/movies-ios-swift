//
//  MoviesView.swift
//  Movies
//
//  Created by Ma'sum on 31/12/24.
//

import SwiftUI

struct MoviesView: View {
    @ObservedObject var interactor: MoviesInteractor
    @ObservedObject var genresInteractor: GenresInteractor
    var genreId: Int

    @State private var isLoading = false

    init(presenter: MoviesInteractor, genresInteractor: GenresInteractor, genreId: Int) {
        self.interactor = presenter
        self.genresInteractor = genresInteractor
        self.genreId = genreId
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                if interactor.movies.isEmpty {
                    Text("No Results")
                } else {
                    LazyVStack {
                        ForEach(interactor.movies) { movie in
                            NavigationLink {
                                MovieDetailModule.build(movieId: movie.id)
                            } label: {
                                MoviesCardView(movieItem: movie)
                                    .padding(.vertical, 1)
                                    .shadow(color: Color.black.opacity(0.4), radius: 4, x: 5, y: 5)
                            }
                            .onAppear {
                                if interactor.movies.last == movie {
                                    loadNextPageIfNeeded()
                                }
                            }
                        }

                        if isLoading {
                            ProgressView()
                                .padding(.vertical)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .background(Color.white)
            .onAppear {
                genresInteractor.loadGenres()
                if interactor.movies.isEmpty {
                    interactor.loadMovies()
                }
            }
        }
        .navigationTitle(navigationTitle)
    }

    private var navigationTitle: String {
        if !genresInteractor.genres.isEmpty {
            if let genreName = genresInteractor.findGenreById(genreId: genreId, genres: genresInteractor.genres) {
                return genreName
            } else {
                return "Genre Not Found"
            }
        } else {
            return "Loading..."
        }
    }

    private func loadNextPageIfNeeded() {
        guard !isLoading else { return }
        isLoading = true
        interactor.loadNextPage {
            isLoading = false
        }
    }
}

// MARK: Preview

let apiClient = APIClient()
let interactor = MoviesInteractor(baseUrl: apiClient.getBaseUrl(), apiKey: apiClient.getApiKey(), genreId: 28)
let genreInteractor = GenresInteractor(baseUrl: apiClient.getBaseUrl(), apiKey: apiClient.getApiKey())

struct Previews_MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView(presenter: interactor, genresInteractor: genreInteractor, genreId: 28)
    }
}
