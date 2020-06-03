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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView), name: NSNotification.Name(rawValue: "updateTable"), object: nil)
        
        if Globals.moviesList.count == 0 {
            fillMoviesList()
        }
    }
    
    @objc func updateTableView () {
        moviesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Globals.moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MainMovieTableViewCell
        
        cell.title?.text = Globals.moviesList[indexPath.row].title
        cell.year?.text = String(getYearFromDate(Globals.moviesList[indexPath.row].date))
        cell.director?.text = Globals.moviesList[indexPath.row].director
        cell.score?.text = String(Globals.moviesList[indexPath.row].score)
        
        cell.moviePoster?.setImage(fromUrlString: Globals.GET_IMAGE_URL + posterSize.small.rawValue + Globals.moviesList[indexPath.row].posterPath)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = moviesTableView.indexPathForSelectedRow {
            let selectedRow = indexPath.row
            let movieDetailsVC = segue.destination as! MovieDetailsViewController
            movieDetailsVC.movie = Globals.moviesList[selectedRow]
        }
    }

}
