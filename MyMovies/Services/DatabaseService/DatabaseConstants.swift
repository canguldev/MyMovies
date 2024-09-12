//
//  DatabaseConstants.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import Foundation

enum DatabaseError: String, Error {
    case failedToSaveData
    case failedToFetchData
    case failedToDeleteData
}
