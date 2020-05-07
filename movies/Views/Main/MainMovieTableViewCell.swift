//
//  MainMovieTableViewCell.swift
//  movies
//
//  Created by Joyce Rosario Batista on 07/05/2020.
//  Copyright © 2020 Joyce Rosario Batista. All rights reserved.
//

import UIKit

class MainMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var score: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moviePoster.image = UIImage(named: "no-picture")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
