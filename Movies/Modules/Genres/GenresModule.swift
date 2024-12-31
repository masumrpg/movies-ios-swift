//
//  GenresModule.swift
//  Movies
//
//  Created by Ma'sum on 31/12/24.
//

import SwiftUI

struct GenresModule {
    static func build() -> some View {
        let apiClient = APIClient()
        let interactor = GenresInteractor(baseUrl: apiClient.getBaseUrl(), apiKey: apiClient.getApiKey())
        
        return GenresView(interactor: interactor)
    }
}

struct GenresModule_Previews: PreviewProvider {
    static var previews: some View {
        GenresModule.build()
    }
}
