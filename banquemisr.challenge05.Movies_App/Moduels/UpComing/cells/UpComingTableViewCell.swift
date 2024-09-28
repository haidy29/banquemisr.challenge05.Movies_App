//
//  UpComingTableViewCell.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 28/09/2024.
//

import UIKit

class UpComingTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var lbltitle: UILabel!
    
    @IBOutlet weak var lblrealseyear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setUpUpComingCell(data: UpComing){
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
