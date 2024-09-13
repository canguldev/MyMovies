//
//  FavoritesViewModel.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import Foundation

class FavoritesViewModel {
    var movieModelDataSource: Observable<[MovieModel]> = Observable(nil)
    var movieModelList: [MovieModel]?
    
    func fetchMovieFromDatabase() {
        MovieDatabaseService.shared.fetchMovieFromDatabase { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movieModelList = movies
                self?.mapmovieModelData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func mapmovieModelData() {
        movieModelDataSource.value = movieModelList
    }
    
    func deleteMovieFromDatabase(model: MovieModel) {
        MovieDatabaseService.shared.deleteMovieFromDatabase(model: model) { result in
            switch result {
            case .success():
                print("")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func rowsCount(movies: [MovieModel]) -> Int {
        return movies.count
    }
}
