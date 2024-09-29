//
//  MovieTableViewCell.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 29/09/2024.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblrealseyear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     
    func setUpMovieCell(data: Movie){
        lbltitle.text = data.title
        lblrealseyear.text = data.releaseDate
        if let posterPath = data.posterPath {
            
            let imageUrlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
            movieImg.cacheImage(urlString: imageUrlString)
            
        } else {
            movieImg.image = UIImage(named: "placeholder")
        }
        
    }
}
