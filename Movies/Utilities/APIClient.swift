//
//  APIClient.swift
//  Movies
//
//  Created by Ma'sum on 31/12/24.
//

import Foundation

class APIClient {
    private let baseURL: String = "https://api.themoviedb.org/3"
    private let apiKey: String = "ab8ca7862f2733af2356c592de5f9d45"

    func getApiKey() -> String {
        return apiKey
    }
    
    func getBaseUrl() -> String {
        return baseURL
    }
}
