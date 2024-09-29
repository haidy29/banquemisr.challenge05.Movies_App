//
//  UpComingViewModel.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 28/09/2024.
//

import Foundation
protocol UpComingViewModelProtocol{
    var bindResultToViewController :(() -> ()) { get set }
    
    func getUpComingdata()
    func getUpComingdetails(index: Int) -> Movie
    func getUpComingCount() -> Int
}


class UpComingViewModel : UpComingViewModelProtocol{
    
    
    var nwService : UpComingUseCase?
    var bindResultToViewController :(() -> ()) = {}
    var UpCominglist:  ApiMovieResponse
    
    init(){
        nwService = UpComingUseCase(nwService: RequestData())
        self.UpCominglist = ApiMovieResponse(results: [])
        
    }
    func getUpComingCount() -> Int{
        UpCominglist.results?.count ?? 0
    }
    
    func getUpComingdetails(index: Int) -> Movie{
        
        return UpCominglist.results?[index] ?? Movie()
    }

    func getUpComingdata(){
        nwService?.getUpComing { [weak self] Comingdata in
            
            DispatchQueue.main.async {
                
                self?.UpCominglist = Comingdata!
                self?.bindResultToViewController()
                
            }
        }
    }
    
    
}
