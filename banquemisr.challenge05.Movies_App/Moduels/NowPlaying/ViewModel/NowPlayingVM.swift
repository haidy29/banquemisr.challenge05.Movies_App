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
    func getNowPlayingdetails(index: Int) -> NowPlaying
    func getNowPlayingCount() -> Int
    //func deletSportdetails(chosedindex: Int)
    //func getLeagueId(index: Int) -> Int
    
    
}


class NowPlayingViewModel : NowPlayingViewModelProtocol{
    
    
    var nwService : NowPlayingNWService?
    var bindResultToViewController :(() -> ()) = {}
    var NowPlayinglist:  NowPlayingResponse
    
    init(){
        nwService = NowPlayingNWService(nwService: RequestData())
        self.NowPlayinglist = NowPlayingResponse(results: [])
        
    }
    func getNowPlayingCount() -> Int{
        NowPlayinglist.results?.count ?? 0
    }
    
    func getNowPlayingdetails(index: Int) -> NowPlaying{
        
        return NowPlayinglist.results?[index] ?? NowPlaying()
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
