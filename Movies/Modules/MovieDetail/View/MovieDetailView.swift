//
//  MovieDetailView.swift
//  Movies
//
//  Created by Ma'sum on 01/01/25.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var interactor: MoviesDetailInteractor
    var movieId: Int

    init(interactor: MoviesDetailInteractor, movieId: Int) {
        self.interactor = interactor
        self.movieId = movieId
    }

    var body: some View {
            ScrollView {
                VStack {
                    if let movieDetail = interactor.movieDetail {
                        if let posterPath = movieDetail.posterPath, !posterPath.isEmpty {
                            let posterUrl = "https://image.tmdb.org/t/p/w500" + posterPath
                            AsyncImage(url: URL(string: posterUrl)) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 300)
                            } placeholder: {
                                ProgressView()
                            }
                            .padding(.top, 20)
                        }

                        Text(movieDetail.title)
                            .font(.largeTitle)
                            .bold()
                            .padding(.top, 20)
                        
                        Text(movieDetail.overview)
                            .padding()
                        
                        Text("Release Date: \(movieDetail.releaseDate)")
                            .padding(.bottom, 10)
                        
                        Text("Rating: \(movieDetail.voteAverage, specifier: "%.1f")")
                            .padding(.bottom, 10)
                        

                        if let imdbId = movieDetail.imdbId {
                                        let videoUrl = "https://www.imdb.com/video/vi3543773721/?playlistId=\(imdbId)"
                                        NavigationLink(destination: VideoPlaybackView(videoURL: URL(string: videoUrl)!)) {
                                            Text("Watch Video on IMDb")
                                                .foregroundColor(.blue)
                                                .padding()
                                        }
                                    }
                    } else {
                        Text("Loading...")
                            .padding(.top, 20)
                    }
                }
                .onAppear {
                    interactor.loadMovieDetail(movieId: movieId)
                }
                .navigationTitle("Movie Detail")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let apiClient = APIClient()
        let mockInteractor = MoviesDetailInteractor(baseUrl: apiClient.getBaseUrl(), apiKey: apiClient.getApiKey())
        
        MovieDetailView(interactor: mockInteractor, movieId: 28)
            .onAppear {
                mockInteractor.loadMovieDetail(movieId: 28)
            }
    }
}
