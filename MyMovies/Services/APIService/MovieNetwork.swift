//
//  MovieNetwork.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import Foundation
import Alamofire

protocol MovieNetworkProtocol {
    func fetchMovies(endpoint: EndPoint, completion: @escaping (Result<Movies, NetworkError>) -> Void)
    func searchMovies(query: String, endpoint: EndPoint, completion: @escaping (Result<Movies, NetworkError>) -> Void)
}

final class MovieNetwork: MovieNetworkProtocol {
    static let shared = MovieNetwork()
    private init() {}
    
    func fetchMovies(endpoint: EndPoint, completion: @escaping (Result<Movies, NetworkError>) -> Void) {
        NetworkCaller.shared.fetchData(endpoint, completion: completion)
    }
    
    func searchMovies(query: String, endpoint: EndPoint, completion: @escaping (Result<Movies, NetworkError>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        NetworkCaller.shared.searchData(query: query, endpoint, completion: completion)
    }
}
