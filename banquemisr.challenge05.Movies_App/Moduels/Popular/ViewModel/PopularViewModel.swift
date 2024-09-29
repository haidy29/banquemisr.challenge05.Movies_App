//
//  PopularViewModel.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 28/09/2024.
//

import Foundation
protocol PopularViewModelProtocol{
    var bindResultToViewController :(() -> ()) { get set }
    
    func getPopulardata()
    func getPopulardetails(index: Int) -> Movie
    func getPopularCount() -> Int
}


class PopularViewModel : PopularViewModelProtocol{
    
    
    var nwService : PopularUseCase?
    var bindResultToViewController :(() -> ()) = {}
    var Popularlist:  ApiMovieResponse
    
    init(){
        nwService = PopularUseCase(nwService: RequestData())
        self.Popularlist = ApiMovieResponse(results: [])
        
    }
    func getPopularCount() -> Int{
        Popularlist.results?.count ?? 0
    }
    
    func getPopulardetails(index: Int) -> Movie{
        
        return Popularlist.results?[index] ?? Movie()
    }

    func getPopulardata(){
        nwService?.getPopular { [weak self] Comingdata in
            
            DispatchQueue.main.async {
                
                self?.Popularlist = Comingdata!
                self?.bindResultToViewController()
                
            }
        }
    }
    
    
}
