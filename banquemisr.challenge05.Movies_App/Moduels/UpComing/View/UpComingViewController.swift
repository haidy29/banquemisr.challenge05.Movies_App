//
//  ViewController.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 27/09/2024.
//

import UIKit

class UpComingViewController:  UIViewController , UITableViewDelegate, UITableViewDataSource{
   
    

    @IBOutlet weak var tableView: UITableView!
    
    var upComingViewModel :UpComingViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        upComingViewModel = UpComingViewModel()
        upComingViewModel.bindResultToViewController = { [weak self] in
            self?.renderTableView()
        }
        upComingViewModel.getUpComingdata()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        upComingViewModel.getUpComingCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! UpComingTableViewCell
        let showeditem = upComingViewModel.getUpComingdetails(index: indexPath.row)
        cell.setUpUpComingCell(data: showeditem)
        
        return cell
    }
    
    func renderTableView() {
        tableView.reloadData()
    }
}
