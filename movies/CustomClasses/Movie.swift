//
//  Movie.swift
//  movies
//
//  Created by Joyce Rosario Batista on 06/05/2020.
//  Copyright © 2020 Joyce Rosario Batista. All rights reserved.
//

import UIKit

class Movie: NSObject {
    var id: Int = Int()
    var title: String = String()
    var posterPath: String = String()
    var date: Date = Date()
    var director: String = String()
    var score: Double = Double()
    var backdropPosterPath: String = String()
    var duration: Int = Int()
    var movieDescription: String = String()
}
