//
//  NowPlayingViewController.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 27/09/2024.
//

import UIKit

class NowPlayingViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var nowPlayingViewModel :NowPlayingViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        nowPlayingViewModel = NowPlayingViewModel()
        nowPlayingViewModel.bindResultToViewController = { [weak self] in
            self?.renderTableView()
        }
        nowPlayingViewModel.getNowPlayingdata()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nowPlayingViewModel.getNowPlayingCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! NowPlayingTableViewCell
        let showeditem = nowPlayingViewModel.getNowPlayingdetails(index: indexPath.row)
        cell.setUpNowPlayingCell(data: showeditem)
        
        return cell
    }
    
    func renderTableView() {
        tableView.reloadData()
    }
}
