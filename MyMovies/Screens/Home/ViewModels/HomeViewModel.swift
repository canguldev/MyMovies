//
//  HomeViewModel.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import Foundation

class HomePageViewModel {
    var nowPlayingDataSource: Observable<[HomeCellViewModel]> = Observable(nil)
    var popularDataSource: Observable<[HomeCellViewModel]> = Observable(nil)
    var topRatedDataSource: Observable<[HomeCellViewModel]> = Observable(nil)
    var dataSource: Movies?
    
    func fetchMovies() {
        fetchMoviesHelperFunction(endpoint: .nowPlaying, mapDataFunc: mapNowPlayingData)
        fetchMoviesHelperFunction(endpoint: .popular, mapDataFunc: mapPopularData)
        fetchMoviesHelperFunction(endpoint: .topRated, mapDataFunc: mapTopRatedData)
    }
    
    private func fetchMoviesHelperFunction(endpoint: EndPoint, mapDataFunc: @escaping () -> ()) {
        MovieNetwork.shared.fetchMovies(endpoint: endpoint) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.dataSource = movies
                mapDataFunc()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func mapNowPlayingData() {
        nowPlayingDataSource.value = dataSource?.results?.compactMap({HomeCellViewModel(movie: $0)})
    }
    private func mapPopularData() {
        popularDataSource.value = dataSource?.results?.compactMap({HomeCellViewModel(movie: $0)})
    }
    private func mapTopRatedData() {
        topRatedDataSource.value = dataSource?.results?.compactMap({HomeCellViewModel(movie: $0)})
    }
    
    func headerTitle(stringList: [String], section: Int) -> String? {
        return stringList[section]
    }
    
    func sectionsCount(stringList: [String]) -> Int {
        return stringList.count
    }
    
    func rowsCount() -> Int {
        return 1
    }
}
