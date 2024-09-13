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
    
    func saveMovieToDatabase(movie: Movie) {
        MovieDatabaseService.shared.saveMovieToDatabase(model: movie) { result in
            switch result {
            case .success():
                print("")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func makeImageUrl(_ imageString: String) -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(imageString)") ?? URL(string: "https://images.pexels.com/photos/3945313/pexels-photo-3945313.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")
    }
}
