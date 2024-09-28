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
    func getUpComingdetails(index: Int) -> UpComing
    func getUpComingCount() -> Int
}


class UpComingViewModel : UpComingViewModelProtocol{
    
    
    var nwService : UpComingNWService?
    var bindResultToViewController :(() -> ()) = {}
    var UpCominglist:  UpComingResponse
    
    init(){
        nwService = UpComingNWService(nwService: RequestData())
        self.UpCominglist = UpComingResponse(results: [])
        
    }
    func getUpComingCount() -> Int{
        UpCominglist.results?.count ?? 0
    }
    
    func getUpComingdetails(index: Int) -> UpComing{
        
        return UpCominglist.results?[index] ?? UpComing()
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
