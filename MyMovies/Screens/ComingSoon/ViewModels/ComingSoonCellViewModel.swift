//
//  ComingSoonCellViewModel.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import Foundation

class ComingSoonCellViewModel {
    var imageURL: URL?
    
    init(movie: Movie) {
        self.imageURL = makeImageUrl(movie.posterPath ?? "")
    }
    
    private func makeImageUrl(_ imageString: String) -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(imageString)") ?? URL(string: "https://images.pexels.com/photos/3945313/pexels-photo-3945313.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")
    }
}
