//
//  PopularUseCase.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 29/09/2024.
//

import Foundation

class PopularUseCase{
    
    var nwService : RequestDataProtocol
    
    init(nwService: RequestDataProtocol) {
        self.nwService = nwService
    }
    
    func getPopular(handler: @escaping (ApiMovieResponse?) -> Void){
        
        nwService.requestData(url: URLs.Instance.getPopular(),
                              handler: handler)
    }
}
