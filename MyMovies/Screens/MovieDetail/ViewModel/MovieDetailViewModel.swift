//
//  MovieDetailViewModel.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import Foundation

class MovieDetailViewModel {
    var movie: Movie
    var title: String
    var voteLabel: String
    var description: String
    var movieImage: URL?
    
    init(movie: Movie) {
        self.movie = movie
        self.title = movie.title ?? ""
        self.voteLabel = "⭐️ \(String(format: "%.1f", movie.voteAverage ?? 0.0)) (\(movie.voteCount ?? 0))"
        self.description = movie.overview ?? ""
        self.movieImage = makeImageUrl(movie.backdropPath ?? "")
    }
    
    private func makeImageUrl(_ imageString: String) -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(imageString)") ?? URL(string: "https://t3.ftcdn.net/jpg/03/27/55/60/360_F_327556002_99c7QmZmwocLwF7ywQ68ChZaBry1DbtD.jpg")
    }
}
