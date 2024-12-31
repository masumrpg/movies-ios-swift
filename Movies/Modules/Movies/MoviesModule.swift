//
//  MoviesModule.swift
//  Movies
//
//  Created by Ma'sum on 31/12/24.
//

import SwiftUI

struct MoviesModule {
    static func build(genreId: Int) -> some View {
        let apiClient = APIClient()
        
        let presenter = MoviesInteractor(baseUrl: apiClient.getBaseUrl(), apiKey: apiClient.getApiKey(), genreId: genreId)
        
        let genreInteractor = GenresInteractor(baseUrl: apiClient.getBaseUrl(), apiKey: apiClient.getApiKey())
        
        
        return MoviesView(presenter: presenter, genresInteractor: genreInteractor, genreId: genreId)
    }
}
