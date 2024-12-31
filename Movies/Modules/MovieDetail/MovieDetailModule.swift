//
//  MovieDetailModule.swift
//  Movies
//
//  Created by Ma'sum on 01/01/25.
//

import SwiftUI

struct MovieDetailModule {
    static func build(movieId: Int) -> some View {
        let apiClient = APIClient()
        let interactor = MoviesDetailInteractor(baseUrl: apiClient.getBaseUrl(), apiKey: apiClient.getApiKey())
        
        return MovieDetailView(interactor: interactor, movieId: movieId)
    }
}

struct MovieDetailModule_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailModule.build(movieId: 28)
    }
}
