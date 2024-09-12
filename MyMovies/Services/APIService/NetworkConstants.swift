//
//  NetworkConstants.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: String, Error {
    case unableToCompleteError
    case invalidResponse
    case invalidData
    case unknownError
    case decodingError
}

protocol EndPointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var apiKey: String { get }
    var method: HTTPMethod { get }
    func moviesApiUrl() -> String
    func request() -> URLRequest
}

enum EndPoint {
    case nowPlaying
    case popular
    case topRated
    case upcoming
    case search
}

extension EndPoint: EndPointProtocol {
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "movie/now_playing"
        case .popular:
            return "movie/popular"
        case .topRated:
            return "movie/top_rated"
        case .upcoming:
            return "movie/upcoming"
        case .search:
            return "search/movie"
        }
    }
    
    var apiKey: String {
        return ""
    }
    
    var method: HTTPMethod {
        switch self {
        case .nowPlaying:
            return .get
        case .popular:
            return .get
        case .topRated:
            return .get
        case .upcoming:
            return .get
        case .search:
            return .get
        }
    }
    
    func moviesApiUrl() -> String {
        return "\(baseURL)\(path)\(apiKey)"
    }
    
    func searchApiUrl() -> String {
        return "\(baseURL)\(path)\(apiKey)&query="
    }
    
    func searchRequest(query: String) -> URLRequest {
        guard let component = URLComponents(string: "\(searchApiUrl())\(query)") else { fatalError("Base URL Error")}
        guard let url = component.url else { fatalError("URL Error from component") }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
    
    func request() -> URLRequest {
        guard let component = URLComponents(string: moviesApiUrl()) else { fatalError("Base URL Error") }
        guard let url = component.url else { fatalError("URL Error from component") }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
}
