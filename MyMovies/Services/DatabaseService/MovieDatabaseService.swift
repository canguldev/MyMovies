//
//  MovieDatabaseService.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import UIKit
import CoreData

class MovieDatabaseService {
    static let shared = MovieDatabaseService()
    private init() {}
    
    func saveMovieToDatabase(model: Movie, completion: @escaping (Result<Void, DatabaseError>) -> Void) {
        guard let appDelagate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelagate.persistentContainer.viewContext
        
        let movie = MovieModel(context: context)
        movie.title = model.title
        movie.overview = model.overview
        guard let voteAverage = model.voteAverage else { return }
        movie.voteAverage = voteAverage
        guard let voteCount = model.voteCount else { return }
        movie.voteCount = Int64(voteCount)
        movie.backdropPath = model.backdropPath
        movie.posterPath = model.posterPath
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(.failedToSaveData))
        }
    }
    
    func fetchMovieFromDatabase(completion: @escaping (Result<[MovieModel], DatabaseError>) -> Void) {
        guard let appDelagate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelagate.persistentContainer.viewContext
        
        let request: NSFetchRequest<MovieModel>
        request = MovieModel.fetchRequest()
        
        do {
            let movies = try context.fetch(request)
            completion(.success(movies))
        } catch {
            completion(.failure(.failedToFetchData))
        }
    }
    
    func deleteMovieFromDatabase(model: MovieModel, completion: @escaping (Result<Void, DatabaseError>) -> Void) {
        guard let appDelagate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelagate.persistentContainer.viewContext
        
        context.delete(model)
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(.failedToDeleteData))
        }
    }
}
