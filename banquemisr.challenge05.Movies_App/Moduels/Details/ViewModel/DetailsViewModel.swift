//
//  DetailsViewModel.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 29/09/2024.
//

import Foundation
import Network
protocol DetailsViewModelProtocol{
    var bindResultToViewController: ((DetailsResponse) -> ()) { get set }
    func  getDetailsdata(movieId: Int)
    func setupNetworkMonitoring(movieId: Int)
    func stopMonitor()
}


class DetailsViewModel : DetailsViewModelProtocol{
    
    private var monitor : NWPathMonitor?
    
    var nwService : DetailsUseCase?
    var bindResultToViewController: ((DetailsResponse) -> ()) = { _ in }
    var detailsData :  DetailsResponse
    
    init(){
        nwService = DetailsUseCase(nwService: RequestData())
        self.detailsData = DetailsResponse()
        
    }
    
    func getDetailsdata(movieId: Int){
        nwService?.getDetails(movieId: movieId){ [weak self] Comingdata in
            self?.detailsData = Comingdata ?? DetailsResponse()
            self?.saveInUserdefult(movieId: movieId, movieData: self?.detailsData ?? DetailsResponse())
            DispatchQueue.main.async {
                self?.bindResultToViewController(self?.detailsData ?? DetailsResponse())
            }
        }
    }
    
    func saveInUserdefult(movieId: Int, movieData: DetailsResponse){
        nwService?.saveInUserdefult(movieId: movieId, movieData: movieData)
    }
    
    func getFromUserDefult(movieId: Int) -> DetailsResponse?{
        let movieData = nwService?.getFromUserDefult(movieId: movieId)
        return movieData
    }
    
    func setupNetworkMonitoring(movieId: Int) {
        monitor = NWPathMonitor()
        
        monitor?.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    
                    print("Internet is available")
                    self?.getDetailsdata(movieId: movieId)
                } else {
                    print("No internet connection")
                    self?.detailsData = self?.nwService?.getFromUserDefult(movieId: movieId) ?? DetailsResponse()
                    self?.bindResultToViewController(self?.detailsData ?? DetailsResponse())
                }
            }
        }
        monitor?.start(queue:.main)
    }
    
    func stopMonitor(){
        monitor?.cancel()
    }
}
