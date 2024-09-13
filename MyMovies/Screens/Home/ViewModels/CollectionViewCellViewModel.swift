//
//  CollectionViewCellViewModel.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import Foundation

class CollectionViewCellViewModel {
    
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
    
    func itemsCount(cellDataSource: [HomeCellViewModel]) -> Int {
        return cellDataSource.count
    }
}
