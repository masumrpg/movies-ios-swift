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
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(interactor.movies) { movie in
                                NavigationLink {
                                    MovieDetailModule.build(movieId: movie.id)
                                } label: {
                                    MoviesCardView(movieItem: movie)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .background(Color.white)
        }
        .navigationTitle(navigationTitle)
        .onAppear {
            interactor.loadTrending()
            genresInteractor.loadGenres()
        }
    }

    private var navigationTitle: String {
        if let genreName = genresInteractor.findGenreById(genreId: genreId, genres: genresInteractor.genres) {
            return genreName
        } else {
            return "..."
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
