//
//  DetailsUseCase.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 29/09/2024.
//

import Foundation
class DetailsUseCase{
    
    var nwService : RequestDataProtocol
    
    init(nwService: RequestDataProtocol) {
        self.nwService = nwService
    }
    
    func getDetails(movieId: Int ,handler: @escaping (DetailsResponse?) -> Void){
        
        nwService.requestData(url: URLs.Instance.getdetails(movieId: movieId),
                              handler: handler)
    }
    
    func saveInUserdefult(movieId: Int, movieData: DetailsResponse){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(movieData)
            UserDefaults.standard.set(data, forKey: "\(movieId)")
            
        } catch {
            print("Unable to Encode Note (\(error))")
        }
        print(getFromUserDefult(movieId: movieId))
    }
    
    func getFromUserDefult(movieId: Int) -> DetailsResponse{
        var movieData = DetailsResponse()
        if let data = UserDefaults.standard.data(forKey:"\(movieId)") {
            do {
                movieData = try JSONDecoder().decode(DetailsResponse.self, from: data)
            }catch{
                print("hey check me out!!")
            }
        }
        return movieData
    }
    
}
