//
//  GenresView.swift
//  Movies
//
//  Created by Ma'sum on 31/12/24.
//

import SwiftUI

struct GenresView: View {
    @ObservedObject var interactor: GenresInteractor

    static let gradientColors: [[Color]] = [
        [.red, .yellow],
        [.blue, .purple],
        [.green, .blue],
        [.orange, .pink],
        [.teal, .indigo],
        [.yellow, .purple],
        [.green, .teal],
        [.pink, .red],
        [.indigo, .orange],
        [.purple, .blue]
    ]

    init(interactor: GenresInteractor) {
        self.interactor = interactor
    }

    var body: some View {
        NavigationStack {
            VStack {
                if interactor.genres.isEmpty {
                    Text("Loading genres...")
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: 10),
                                GridItem(.flexible(), spacing: 10)
                            ],
                            spacing: 10
                        ) {
                            ForEach(interactor.genres.indices, id: \.self) { index in
                                let genre = interactor.genres[index]
                                let colors = GenresView.gradientColors[index % GenresView.gradientColors.count]
                                
                                NavigationLink(destination: MoviesModule.build(genreId: genre.id)) {
                                    GenreCardView(
                                        genreName: genre.name,
                                        gradientColors: colors
                                    )
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .onAppear {
                interactor.loadGenres()
            }
        }
        .navigationTitle("Genres")
    }
}



// PreviewProvider
struct GenresView_Previews: PreviewProvider {
    static var previews: some View {
        let apiClient = APIClient()
        
        let mockInteractor = GenresInteractor(baseUrl: apiClient.getBaseUrl(), apiKey: apiClient.getApiKey())
        return GenresView(interactor: mockInteractor)
    }
}
