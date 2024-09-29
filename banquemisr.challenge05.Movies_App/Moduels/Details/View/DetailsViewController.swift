//
//  DetailsViewController.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 29/09/2024.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblgenre: UILabel!
    @IBOutlet weak var lbloverview: UILabel!
    @IBOutlet weak var lblruntime: UILabel!
    
    var movieId = 0
    var detailsViweModel: DetailsViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsViweModel = DetailsViewModel()
        detailsViweModel.bindResultToViewController = { [weak self] details in
            self?.lbltitle.text = details.title
            self?.lblgenre.text = "Genre: \(details.genres?.first?.name ?? "")"
            self?.lblruntime.text = "Runtime: \(details.runtime ?? 0)"
            self?.lbloverview.text = details.overview
            if let posterPath = details.posterPath {
                
                let imageUrlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
                self?.movieImg.cacheImage(urlString: imageUrlString)
                
            } else {
                self?.movieImg.image = UIImage(named: "placeholder")
            }
            
        }
        //detailsViweModel.getDetailsdata(movieId: movieId)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        detailsViweModel.setupNetworkMonitoring(movieId: movieId)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        detailsViweModel.stopMonitor()
    }
    
    
}
