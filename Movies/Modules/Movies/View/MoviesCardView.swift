//
//  TrendingCard.swift
//  Movies
//
//  Created by Ma'sum on 31/12/24.
//


import Foundation
import SwiftUI

struct MoviesCardView: View {

    let movieItem: Movie

    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: movieItem.backdropURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 340, height: 240)
            } placeholder: {
                Rectangle().fill(Color("GrayToWhite"))
                        .frame(width: 340, height: 240)
            }

            VStack {
                HStack {
                    Text(movieItem.title)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 20))
                }
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                    Text(String(format: "%.1f", movieItem.vote_average))
                    Spacer()
                }
                .foregroundColor(.yellow)
                .fontWeight(.heavy)
            }
            .padding()
            .background(
                .ultraThinMaterial
            )
        }
        .cornerRadius(10)
    }
}

// Preview

struct Previews_MoviesCardView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesCardView(movieItem: .preview)
    }
}
