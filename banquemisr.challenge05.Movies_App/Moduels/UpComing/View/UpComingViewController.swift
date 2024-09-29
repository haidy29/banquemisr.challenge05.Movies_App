//
//  ViewController.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 27/09/2024.
//

import UIKit

class UpComingViewController:  UIViewController {
    
    @IBOutlet weak var upComingTableView: UITableView!{
        didSet{
            upComingTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        }
    }
    
    var upComingViewModel :UpComingViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upComingTableView.dataSource = self
        upComingTableView.delegate = self
        upComingViewModel = UpComingViewModel()
        upComingViewModel.bindResultToViewController = { [weak self] in
            self?.renderTableView()
        }
      // upComingViewModel.getUpComingdata()
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        upComingViewModel.setupNetworkMonitoring()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
        upComingViewModel.stopMonitor()
        }
    
    func renderTableView() {
        upComingTableView.reloadData()
    }
}


