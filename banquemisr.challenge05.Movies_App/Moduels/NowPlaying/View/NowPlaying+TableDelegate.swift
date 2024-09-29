//
//  NowPlaying+TableDelegate.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 29/09/2024.
//

import UIKit

extension NowPlayingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nowPlayingViewModel.getNowPlayingCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath)as! MovieTableViewCell
        let showeditem = nowPlayingViewModel.getNowPlayingdetails(index: indexPath.row)
        cell.setUpMovieCell(data: showeditem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetails = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        movieDetails.movieId = nowPlayingViewModel.getMovieId(index: indexPath.row)
        self.navigationController?.pushViewController(movieDetails, animated: true)
    }
    
}
