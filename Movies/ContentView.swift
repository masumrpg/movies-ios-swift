//
//  ContentView.swift
//  Movies
//
//  Created by Ma'sum on 31/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            GenresModule.build()
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

