//
//  NowPlayingVM.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 28/09/2024.
//

import Foundation

protocol NowPlayingViewModelProtocol{
    var bindResultToViewController :(() -> ()) { get set }
    
    func getNowPlayingdata()
    func getNowPlayingdetails(index: Int) -> Movie
    func getNowPlayingCount() -> Int
}


class NowPlayingViewModel : NowPlayingViewModelProtocol{
    
    
    var nwService : NowPlayingUseCase?
    var bindResultToViewController :(() -> ()) = {}
    var NowPlayinglist:  ApiMovieResponse
    
    init(){
        nwService = NowPlayingUseCase(nwService: RequestData())
        self.NowPlayinglist = ApiMovieResponse(results: [])
        
    }
    func getNowPlayingCount() -> Int{
        NowPlayinglist.results?.count ?? 0
    }
    
    func getNowPlayingdetails(index: Int) -> Movie{
        
        return NowPlayinglist.results?[index] ?? Movie()
    }

    func getNowPlayingdata(){
        nwService?.getNowPlaying { [weak self] Comingdata in
            
            DispatchQueue.main.async {
                
                self?.NowPlayinglist = Comingdata!
                self?.bindResultToViewController()
                
            }
        }
    }
    
    
}
