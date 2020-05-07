//
//  GlobalFuntions.swift
//  movies
//
//  Created by Joyce Rosario Batista on 06/05/2020.
//  Copyright © 2020 Joyce Rosario Batista. All rights reserved.
//

import UIKit
import SwiftyJSON

public func getPopularMoviesURL() -> String {
    return Globals.BASE_URL + "movie/popular?api_key=" + Globals.TMDB_API_KEY + "&language=" + Globals.LANGUAGE + "&page=1"
}

public func getMovieDetailsURL(_ id: Int) -> String {
    return Globals.BASE_URL + "movie/" + String(id) + "?api_key=" + Globals.TMDB_API_KEY + "&language=" + Globals.LANGUAGE + "&" + Globals.APPEND_CREDITS_TO_RESPONSE
}

public func fillMoviesList() {
    NetworkClient().getPopularMovies( { (popularMovies) in
        popularMovies!["results"].array?.forEach({ (popularMovie) in
            NetworkClient().getMovieDetails(popularMovie["id"].intValue, { (movieDetails) in                
                let newMovie: Movie = Movie()
                newMovie.id = movieDetails!["id"].intValue
                newMovie.title = movieDetails!["title"].stringValue
                newMovie.score = movieDetails!["vote_average"].doubleValue
                newMovie.movieDescription = movieDetails!["overview"].stringValue
                newMovie.posterPath = movieDetails!["poster_path"].stringValue
                newMovie.date = getDateFromString(movieDetails!["release_date"].stringValue)
                newMovie.duration = movieDetails!["runtime"].intValue
                newMovie.backdropPosterPath = movieDetails!["backdrop_path"].stringValue
                
                movieDetails!["credits"]["crew"].array?.forEach({ ( crew ) in
                    let directorJob = crew["job"]
                    if (directorJob == "Director") {
                        newMovie.director = crew["name"].stringValue
                    }
                })
                
                Globals.moviesList.append(newMovie)
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateTable"), object: nil)
            })
        })
    })
}

public func getDateFromString(_ dateString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: dateString)!
}

public func getYearFromDate(_ date: Date) -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year], from: date)
    return components.year!
}

public func getStringFromDate(date: Date, withFormat format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}
