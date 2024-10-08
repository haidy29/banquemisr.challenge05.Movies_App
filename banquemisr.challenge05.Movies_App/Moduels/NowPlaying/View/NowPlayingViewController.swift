//
//  NowPlayingViewController.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 27/09/2024.
//

import UIKit

class NowPlayingViewController: UIViewController {
    
    @IBOutlet weak var nowPlayingTableView: UITableView!{
        didSet{
            nowPlayingTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        }
    }
    
    var nowPlayingViewModel: NowPlayingViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nowPlayingTableView.dataSource = self
        nowPlayingTableView.delegate = self
        
        nowPlayingViewModel = NowPlayingViewModel()
        nowPlayingViewModel.bindResultToViewController = { [weak self] in
            self?.renderTableView()
        }
//        nowPlayingViewModel.getNowPlayingdata()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nowPlayingViewModel.setupNetworkMonitoring()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            nowPlayingViewModel.stopMonitor()
        }
    
    func renderTableView() {
        nowPlayingTableView.reloadData()
    }
}


