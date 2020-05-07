//
//  MainMovieViewController.swift
//  movies
//
//  Created by Joyce Rosario Batista on 07/05/2020.
//  Copyright © 2020 Joyce Rosario Batista. All rights reserved.
//

import UIKit

class MainMovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var moviesTableView: UITableView!
    var moviesList:[Movie] = []
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(MainMovieViewController.updateTable(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.systemBlue
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        
        moviesTableView.addSubview(refreshControl)
//        self.view.addSubview(refreshControl)
        
//        if moviesList.count == 0 {
//            fillMoviesList { (movieDetails) in
//                let newMovie: Movie = Movie()
//                newMovie.id = movieDetails!["id"].intValue
//                newMovie.title = movieDetails!["title"].stringValue
//                newMovie.score = movieDetails!["vote_average"].doubleValue
//                newMovie.movieDescription = movieDetails!["overview"].stringValue
//                newMovie.posterPath = movieDetails!["poster_path"].stringValue
//                newMovie.date = getDateFromString(movieDetails!["release_date"].stringValue)
//                newMovie.duration = movieDetails!["runtime"].intValue
//                newMovie.backdropPosterPath = movieDetails!["backdrop_path"].stringValue
//
//                movieDetails!["credits"]["crew"].array?.forEach({ ( crew ) in
//                    let directorJob = crew["job"]
//                    if (directorJob == "Director") {
//                        newMovie.director = crew["name"].stringValue
//                    }
//                })
//                self.moviesList.append(newMovie)
//            }
//        }
    }

    @objc func updateTable(_ refreshControl: UIRefreshControl) {
        if moviesList.count == 0 {
            fillMoviesList { (movieDetails) in
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
                self.moviesList.append(newMovie)
            }
        }
        
        moviesTableView.reloadData()
        
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MainMovieTableViewCell
        
        if moviesList.count > 0 {
            cell.title?.text = moviesList[indexPath.row].title
        }
        
        return cell
        
    }

}
