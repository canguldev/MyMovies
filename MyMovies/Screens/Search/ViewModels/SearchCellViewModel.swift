//
//  SearchCellViewModel.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import Foundation

class SearchCellViewModel {
    var movie: Movie?
    var title: String
    var imageURL: URL?
    
    init(movie: Movie) {
        self.movie = movie
        self.title = movie.title ?? ""
        self.imageURL = makeImageUrl(imageString: movie.posterPath ?? "")
    }
    
    private func makeImageUrl(imageString: String) -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(imageString)") ?? URL(string: "https://t3.ftcdn.net/jpg/03/27/55/60/360_F_327556002_99c7QmZmwocLwF7ywQ68ChZaBry1DbtD.jpg")
    }
}
