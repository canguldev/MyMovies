//
//  NetworkCaller.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func fetchData<T: Codable>(_ endpoint: EndPoint, completion: @escaping (Result<T, NetworkError>) -> Void)
    func searchData<T: Codable>(query: String?, _ endpoint: EndPoint, completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class NetworkCaller: NetworkManagerProtocol {
    static let shared = NetworkCaller()
    private let decoder = JSONDecoder()
    private init() {}
    
    func fetchData<T: Codable>(_ endpoint: EndPoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        AF.request(endpoint.request()).responseDecodable(of: T.self) { response in
            guard response.error == nil else {
                completion(.failure(.unableToCompleteError))
                return
            }
            
            guard let data = response.data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response.response else {
                completion(.failure(.unableToCompleteError))
                return
            }
            self.decoder.keyDecodingStrategy = .convertFromSnakeCase
            switch response.statusCode {
            case 200...299:
                do {
                    let result = try self.decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError))
                }
            default:
                completion(.failure(.unknownError))
            }
        }
    }
    
    func searchData<T: Codable>(query: String?, _ endpoint: EndPoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let query = query else { return }
        AF.request(endpoint.searchRequest(query: query)).responseDecodable(of: T.self) { response in
            guard response.error == nil else {
                completion(.failure(.unableToCompleteError))
                return
            }
            
            guard let data = response.data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response.response else {
                completion(.failure(.unableToCompleteError))
                return
            }
            self.decoder.keyDecodingStrategy = .convertFromSnakeCase
            switch response.statusCode {
            case 200...299:
                do {
                    let result = try self.decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError))
                }
            default:
                completion(.failure(.unknownError))
            }
        }
    }
}
