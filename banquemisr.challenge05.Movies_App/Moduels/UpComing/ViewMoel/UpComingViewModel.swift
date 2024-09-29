//
//  UpComingViewModel.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 28/09/2024.
//

import Foundation
import Network
protocol UpComingViewModelProtocol{
    var bindResultToViewController :(() -> ()) { get set }
    
    func getUpComingdata()
    func getUpComingdetails(index: Int) -> Movie
    func getUpComingCount() -> Int
    func getMovieId(index: Int) -> Int
    func setupNetworkMonitoring()
    func stopMonitor()
}


class UpComingViewModel : UpComingViewModelProtocol{
    
    private var monitor : NWPathMonitor?
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
    
    func getMovieId(index: Int) -> Int{
        UpCominglist.results?[index].id ?? 0
    }

    func getUpComingdata(){
        nwService?.getUpComing { [weak self] Comingdata in
            self?.UpCominglist = Comingdata ?? ApiMovieResponse(results: [])
            self?.nwService?.saveUpComingToCoreData(data: self?.UpCominglist.results ?? [])
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
                    print("Internet is available")
                    self?.getUpComingdata()
                } else {
                    print("No internet connection")
                    self?.UpCominglist.results = self?.nwService?.fetchUpComingMoviesFromCoreData()
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
