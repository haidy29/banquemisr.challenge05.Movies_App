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
       // popularViewModel.getPopulardata()
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        popularViewModel.setupNetworkMonitoring()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
        popularViewModel.stopMonitor()
        }
    
    func renderTableView() {
        popularTableView.reloadData()
    }
}


