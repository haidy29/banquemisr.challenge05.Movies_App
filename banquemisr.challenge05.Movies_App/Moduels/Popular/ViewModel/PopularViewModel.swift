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
    func getPopulardetails(index: Int) -> Popular
    func getPopularCount() -> Int
}


class PopularViewModel : PopularViewModelProtocol{
    
    
    var nwService : PopularNWService?
    var bindResultToViewController :(() -> ()) = {}
    var Popularlist:  PopularResponse
    
    init(){
        nwService = PopularNWService(nwService: RequestData())
        self.Popularlist = PopularResponse(results: [])
        
    }
    func getPopularCount() -> Int{
        Popularlist.results?.count ?? 0
    }
    
    func getPopulardetails(index: Int) -> Popular{
        
        return Popularlist.results?[index] ?? Popular()
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
