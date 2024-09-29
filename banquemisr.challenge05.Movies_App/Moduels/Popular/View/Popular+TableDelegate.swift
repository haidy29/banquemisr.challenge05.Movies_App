//
//  Popular+TableDelegate.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 29/09/2024.
//

import UIKit
extension PopularViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        popularViewModel.getPopularCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath)as! MovieTableViewCell
        let showeditem = popularViewModel.getPopulardetails(index: indexPath.row)
        cell.setUpMovieCell(data: showeditem)
        
        return cell
    }
}
