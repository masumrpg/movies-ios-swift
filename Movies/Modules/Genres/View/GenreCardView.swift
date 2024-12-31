//
//  GenreCardView.swift
//  Movies
//
//  Created by Ma'sum on 31/12/24.
//

import SwiftUI

struct GenreCardView: View {
    var genreName: String
    var gradientColors: [Color]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: gradientColors),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .cornerRadius(20)
            .shadow(radius: 10)

            
            Text(genreName)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(width: 160, height: 160)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white, lineWidth: 2)
        )
        .padding(10)
    }
}

struct GenreCardView_Previews: PreviewProvider {
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
    
    static let genreNames: [String] = [
        "Action", "Adventure", "Drama", "Comedy", "Horror", "Sci-Fi",
        "Fantasy", "Romance", "Thriller", "Documentary", "Mystery",
        "Western", "Animation", "Biography", "Crime", "Family", "History"
    ]
    
    static var previews: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 10),
                    GridItem(.flexible(), spacing: 10)
                ],
                spacing: 10
            ) {
                ForEach(genreNames.indices, id: \.self) { index in
                    GenreCardView(
                        genreName: genreNames[index],
                        gradientColors: gradientColors[index % gradientColors.count] // Ulangi pola warna
                    )
                }
            }
            .padding()
        }
    }
}


