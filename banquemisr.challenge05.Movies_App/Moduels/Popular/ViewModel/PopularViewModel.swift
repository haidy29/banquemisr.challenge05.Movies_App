//
//  PopularViewModel.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 28/09/2024.
//

import Foundation
import Network
protocol PopularViewModelProtocol{
    var bindResultToViewController :(() -> ()) { get set }
    
    func getPopulardata()
    func getPopulardetails(index: Int) -> Movie
    func getPopularCount() -> Int
    func getMovieId(index: Int) -> Int
    func setupNetworkMonitoring()
    func stopMonitor()
}


class PopularViewModel : PopularViewModelProtocol{
    
    private var monitor : NWPathMonitor?
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
    
    func getMovieId(index: Int) -> Int{
        Popularlist.results?[index].id ?? 0
    }

    func getPopulardata(){
        nwService?.getPopular { [weak self] Comingdata in
            self?.Popularlist = Comingdata ?? ApiMovieResponse(results: [])
            self?.nwService?.savePopularToCoreData(data: self?.Popularlist.results ?? [])
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
                    self?.getPopulardata()
                } else {
                    print("No internet connection")
                    self?.Popularlist.results = self?.nwService?.fetchPopularMoviesFromCoreData()
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
