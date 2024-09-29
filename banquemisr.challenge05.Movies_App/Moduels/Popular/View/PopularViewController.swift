//
//  PopularViewController.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 28/09/2024.
//

import UIKit

class PopularViewController: UIViewController {
     
    @IBOutlet weak var popularTableView: UITableView!{
        didSet{
            popularTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        }
    }
    
    var popularViewModel :PopularViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popularTableView.dataSource = self
        popularTableView.delegate = self
        popularViewModel = PopularViewModel()
        popularViewModel.bindResultToViewController = { [weak self] in
            self?.renderTableView()
        }
        popularViewModel.getPopulardata()
    }
     
    func renderTableView() {
        popularTableView.reloadData()
    }
}


