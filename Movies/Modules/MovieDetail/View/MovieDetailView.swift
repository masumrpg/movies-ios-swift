//
//  MovieDetailView.swift
//  Movies
//
//  Created by Ma'sum on 01/01/25.
//

import SwiftUI

struct MovieDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var interactor: MoviesDetailInteractor
    @ObservedObject var trailerInteractor: TrailerInteractor
    @State private var isPlaying = false

    let movieId: Int
    let headerHeight: CGFloat = 400

    init(interactor: MoviesDetailInteractor, movieId: Int, trailerInteractor: TrailerInteractor ) {
        self.interactor = interactor
        self.movieId = movieId
        self.trailerInteractor = trailerInteractor
    }

    var body: some View {
            ZStack {
                GeometryReader { geometry in
                    VStack {
                        if isPlaying || interactor.videoIdFromImdb.isEmpty {
                            if interactor.videoIdFromImdb.isEmpty {
                                ZStack {
                                      Color.black
                                                                .frame(width: geometry.size.width, height: geometry.size.height * 0.3)
                                                            ProgressView()
                                                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                                                .scaleEffect(1.5)
                                                        }
                                                    } else {
                                                        // Show video only when videoId is available
                                                        TrailerView(videoId: interactor.videoIdFromImdb, autoplay: true)
                                                            .frame(width: geometry.size.width, height: geometry.size.height * 0.3)
                                                    }
                        } else {
                            ZStack {
                                if let movieDetail = interactor.movieDetail {
                                    if let posterPath = movieDetail.backdropPath, !posterPath.isEmpty {
                                        let posterUrl = "https://image.tmdb.org/t/p/w500" + posterPath
                                        
                                       
                                        AsyncImage(url: URL(string: posterUrl)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: geometry.size.width, height: geometry.size.height * 0.3)
                                                .clipped()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }
                                
                               
                                    Image(systemName: "play.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(.red)
                                        .onTapGesture {
                                            isPlaying = true
                                        }
                                } else {
                                    Text("Loading...")
                                        .padding(.top, 20)
                                }
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.3)
                        }
                        
                        
                        ScrollView {
                            VStack(spacing: 20) {
                                VStack(alignment: .leading, spacing: 15) {
                                    // Movie Title and Ratings
                                    HStack {
                                        Text(interactor.movieDetail?.title ?? "Unknown Title")
                                            .font(.title)
                                            .fontWeight(.heavy)
                                            .lineLimit(2)
                                        Spacer()
                                        HStack(spacing: 5) {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                            Text(String(format: "%.1f", interactor.movieDetail?.voteAverage ?? 0.0))
                                                .fontWeight(.semibold)
                                        }
                                    }

                                    // Genre Tags and Running Time
                                    HStack {
                                        if let genres = interactor.movieDetail?.genres {
                                            ForEach(genres.prefix(3), id: \.id) { genre in
                                                Text(genre.name)
                                                    .font(.caption)
                                                    .padding(.horizontal, 10)
                                                    .padding(.vertical, 5)
                                                    .background(Color.blue.opacity(0.2))
                                                    .cornerRadius(10)
                                            }
                                        }
                                        Spacer()
                                    }

                                    Divider()

                                    // About Section
                                    VStack(alignment: .leading, spacing: 10) {
                                        HStack {
                                            Text("About Film")
                                                .font(.title3)
                                                .fontWeight(.bold)
                                            Spacer()
                                        }
                                        Text(interactor.movieDetail?.overview ?? "No description available.")
                                            .lineLimit(4)
                                            .foregroundColor(.secondary)
                                    }

                                    Divider()

                                    // Cast & Crew Section
                                    VStack(alignment: .leading, spacing: 10) {
                                        HStack {
                                            Text("Cast & Crew")
                                                .font(.title3)
                                                .fontWeight(.bold)
                                            Spacer()
                                        }
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            LazyHStack(spacing: 5) {
                                                ForEach(interactor.castProfiles) { cast in
                                                    CastView(cast: cast)
                                                        .frame(width: 120)
                                                }
                                            }
                                        }
                                    }
                                    
                                    Divider()
                                    
                                    // Reviews
                                    VStack(alignment: .leading, spacing: 10) {
                                        HStack {
                                            Text("Reviews")
                                                .font(.title3)
                                                .fontWeight(.bold)
                                            Spacer()
                                        }
                                        ScrollView(.vertical, showsIndicators: false) {
                                            LazyVStack(spacing: 15) {
                                                ForEach(0...10, id: \.self) { test in
                                                    Text("\(test)")
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white)
                                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                )
                                .padding(.horizontal, 5)
                            }
                            .onAppear {
                                interactor.loadMovieDetail(movieId: movieId)
                                trailerInteractor.loadMovieDetail(movieId: movieId)
                            }
                            .navigationTitle("Movie Detail")
                            .navigationBarTitleDisplayMode(.inline)
                        }
                        
                        
                        
                    }
                }
                .ignoresSafeArea()
                .overlay(alignment: .topLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                            .fontWeight(.bold)
                    }
                    .padding(.leading)
                }
                .toolbar(.hidden, for: .navigationBar)
                .task {
                    await interactor.movieCredits(for: interactor.movieDetail?.id ?? 28)
                    await interactor.loadCastProfiles()
                    await interactor.fetchIMDbVideoID(imdbID: interactor.movieDetail?.imdbId ?? "")
                }
            }
        }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let apiClient = APIClient()
        let mockInteractor = MoviesDetailInteractor(baseUrl: apiClient.getBaseUrl(), apiKey: apiClient.getApiKey())
        let mockTrailerInteractor = TrailerInteractor(baseUrl: apiClient.getBaseUrl(), apiKey: apiClient.getApiKey())

        MovieDetailView(interactor: mockInteractor, movieId: 28, trailerInteractor: mockTrailerInteractor)
            .onAppear {
                mockInteractor.loadMovieDetail(movieId: 28)
            }
    }
}
