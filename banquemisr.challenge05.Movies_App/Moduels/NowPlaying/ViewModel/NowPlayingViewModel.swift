//
//  NowPlayingVM.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 28/09/2024.
//

import Foundation
import Network
protocol NowPlayingViewModelProtocol{
    var bindResultToViewController :(() -> ()) { get set }
    
    func getNowPlayingdata()
    func getNowPlayingdetails(index: Int) -> Movie
    func getNowPlayingCount() -> Int
    func getMovieId(index: Int) -> Int
    func setupNetworkMonitoring()
    func stopMonitor()
}


class NowPlayingViewModel : NowPlayingViewModelProtocol{
    
    private var monitor : NWPathMonitor?
    var nwService : NowPlayingUseCase?
    var bindResultToViewController :(() -> ()) = {}
    var NowPlayinglist:  ApiMovieResponse
    
    init(){
        nwService = NowPlayingUseCase(nwService: RequestData())
        self.NowPlayinglist = ApiMovieResponse(results: [])
    }
    
    func getNowPlayingCount() -> Int{
        print( nwService?.fetchNowPlayingMoviesFromCoreData().count ?? 0)
        return NowPlayinglist.results?.count ?? 0
    }
    
    func getNowPlayingdetails(index: Int) -> Movie{
        return NowPlayinglist.results?[index] ?? Movie()
    }
    
    func getMovieId(index: Int) -> Int{
        NowPlayinglist.results?[index].id ?? 0
    }
    
    func getNowPlayingdata(){
        nwService?.getNowPlaying { [weak self] Comingdata in
            self?.NowPlayinglist = Comingdata ?? ApiMovieResponse(results: [])
            self?.nwService?.saveNowPlayingToCoreData(data: self?.NowPlayinglist.results ?? [])
            
            DispatchQueue.main.async {
                self?.bindResultToViewController()
            }
        }
    }
    
    func setupNetworkMonitoring() {
        monitor = NWPathMonitor()
        
        monitor?.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    //                    self?.NowPlayinglist.results = self?.nwService?.fetchNowPlayingMoviesFromCoreData()
                    //                    self?.bindResultToViewController()
                    //                    print(self?.NowPlayinglist.results?.count ?? 0)
                    print("Internet is available")
                    self?.getNowPlayingdata()
                } else {
                    print("No internet connection")
                    self?.NowPlayinglist.results = self?.nwService?.fetchNowPlayingMoviesFromCoreData()
                    self?.bindResultToViewController()
                }
            }
        }
        monitor?.start(queue:.main)
    }
    
    func stopMonitor(){
        monitor?.cancel()
    }
}
