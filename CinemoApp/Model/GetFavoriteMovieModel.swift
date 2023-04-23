//
//  GetFavoriteMovieModel.swift
//  CinemoApp
//
//  Created by jung on 23/4/2566 BE.
//

import Foundation

// MARK: - GetFavoriteMovieModel
struct GetFavoriteMovieModel {
    
    static var movies: [ListMovieModel] = []
    
    static func addFavoriteMovie(_ movie: ListMovieModel) {
        movies.append(movie)
    }
    
    static func indexOfMovie(title: String) -> Int? {
        guard !movies.isEmpty else {
            return nil
        }
        return movies.firstIndex(where: { $0.title == title })
    }
    
    static func removeIndex(index: Int) -> Bool {
            let filteredMovies = movies.remove(at: index)
            return true
    }
}

