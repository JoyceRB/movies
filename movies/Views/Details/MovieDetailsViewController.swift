//
//  MovieDetailsViewController.swift
//  movies
//
//  Created by Joyce Rosario Batista on 06/05/2020.
//  Copyright © 2020 Joyce Rosario Batista. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    var movie: Movie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backdropImage.image = UIImage(named: "no-picture")
        backdropImage.setImage(fromUrlString: Globals.GET_IMAGE_URL + backdropSize.large.rawValue + movie.backdropPosterPath)
        movieTitle.text = movie.title
        director.text = "By " + movie.director
        date.text = getStringFromDate(date: movie.date, withFormat: "MMMM dd, yyyy")
        duration.text = String(movie.duration)
        movieDescription.text = movie.movieDescription
    }

}
