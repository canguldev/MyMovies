//
//  MovieModel.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import Foundation

struct Movies: Codable {
    let results: [Movie]?
}

struct Movie: Codable {
    let title: String?
    let overview: String?
    let voteAverage: Double?
    let voteCount: Int?
    let backdropPath: String?
    let posterPath: String?
}
