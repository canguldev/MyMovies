//
//  SearchViewModel.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import Foundation

class SearchViewModel {
    var movieDataSource: Observable<[SearchCellViewModel]> = Observable(nil)
    var dataSource: Movies?
    
    func searchMovies(query: String) {
        MovieNetwork.shared.searchMovies(query: query, endpoint: .search) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.dataSource = movies
                self?.mapMovieData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func mapMovieData() {
        movieDataSource.value = dataSource?.results?.compactMap({SearchCellViewModel(movie: $0)})
    }
}
