//
//  PopularViewController.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 28/09/2024.
//

import UIKit

class PopularViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var popularViewModel :PopularViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        popularViewModel = PopularViewModel()
        popularViewModel.bindResultToViewController = { [weak self] in
            self?.renderTableView()
        }
        popularViewModel.getPopulardata()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        popularViewModel.getPopularCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! PopularTableViewCell
        let showeditem = popularViewModel.getPopulardetails(index: indexPath.row)
        cell.setUpPopularCell(data: showeditem)
        
        return cell
    }
    
    func renderTableView() {
        tableView.reloadData()
    }
}
