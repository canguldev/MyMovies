//
//  ComingSoonViewModel.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import Foundation

class ComingSoonViewModel {
    var cellDataSource: Observable<[ComingSoonCellViewModel]> = Observable(nil)
    var dataSource: Movies?
    
    func itemCount() -> Int {
        return dataSource?.results?.count ?? 0
    }
    
    func fetchComingSoonMovies() {
        MovieNetwork.shared.fetchMovies(endpoint: .upcoming) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.dataSource = movies
                self?.mapCellData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func mapCellData() {
        cellDataSource.value = dataSource?.results?.compactMap({ComingSoonCellViewModel(movie: $0)})
    }
    
    func getSelectedMovie(index: Int) -> Movie? {
        guard let selectedMovie = dataSource?.results?[index] else { return nil }
        return selectedMovie
    }
}
