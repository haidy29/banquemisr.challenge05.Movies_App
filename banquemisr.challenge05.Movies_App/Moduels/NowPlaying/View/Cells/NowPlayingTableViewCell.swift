//
//  NowPlayingTableViewCell.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 28/09/2024.
//

import UIKit

class NowPlayingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblreleaseyear: UILabel!
    @IBOutlet weak var movieimg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setUpNowPlayingCell(data: NowPlaying){
        lbltitle.text = data.title
        lblreleaseyear.text = data.releaseDate
        if let posterPath = data.posterPath {
            
            let imageUrlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
            movieimg.cacheImage(urlString: imageUrlString)
            
//
//                movieimg.image = nil
//
//                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
//                    if let data = data, error == nil {
//                        DispatchQueue.main.async {
//                            self.movieimg.image = UIImage(data: data)
//                        }
//                    } else {
//                        print("Error loading image: \(String(describing: error))")
//                    }
//                }.resume()
//            }
        } else {
            movieimg.image = UIImage(named: "placeholder")
        }
        
    }
}
