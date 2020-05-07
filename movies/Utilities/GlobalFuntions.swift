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

public func fillMoviesList(_ completionHandler: @escaping (_ moviesList: JSON?) -> Void) {    
    NetworkClient().getPopularMovies( { (popularMovies) in
        popularMovies!["results"].array?.forEach({ (popularMovie) in
            NetworkClient().getMovieDetails(popularMovie["id"].intValue, { (movieDetails) in
                completionHandler(movieDetails)
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


public func getPosterImage(posterPath: String) -> UIImage? {
    let url = URL(string: Globals.GET_IMAGE_URL + posterSize.small.rawValue + posterPath)
    if let data = try? Data(contentsOf: url!) {
        return UIImage(data: data)!
    }
    return nil
}

public func getBackdropImage(backdropPath: String) -> UIImage? {
    let url = URL(string: Globals.GET_IMAGE_URL + backdropSize.medium.rawValue + backdropPath)
    if let data = try? Data(contentsOf: url!) {
        return UIImage(data: data)!
    }
    return nil
}
