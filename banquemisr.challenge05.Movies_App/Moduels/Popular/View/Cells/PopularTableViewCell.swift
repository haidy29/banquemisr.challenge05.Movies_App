//
//  PopularTableViewCell.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 28/09/2024.
//

import UIKit

class PopularTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImg: UIImageView!
   
    @IBOutlet weak var lblreleaseyear: UILabel!
    
    @IBOutlet weak var lbltitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setUpPopularCell(data: Popular){
        lbltitle.text = data.title
        lblreleaseyear.text = data.releaseDate
        if let posterPath = data.posterPath {
            
            let imageUrlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
            movieImg.cacheImage(urlString: imageUrlString)
            
        } else {
            movieImg.image = UIImage(named: "placeholder")
        }
        
    }
}



