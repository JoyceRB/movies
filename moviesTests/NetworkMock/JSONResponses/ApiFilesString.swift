//
//  ApiFilesString.swift
//  TempbuddyV2Tests
//
//  Created by Joyce Rosario on 31/03/2020.
//  Copyright © 2020 TempBuddy. All rights reserved.
//

import Foundation

enum ApiFileStringKey: String {
       
    case getPopularMovies = "get_popular_movies"
    case getMovieDetails = "get_movie_details"
    
    func stringValue() -> String {
        return self.rawValue
    }
}
