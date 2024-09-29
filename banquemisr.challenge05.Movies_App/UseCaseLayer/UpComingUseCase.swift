//
//  UpComingUseCase.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 28/09/2024.
//

import Foundation

class UpComingUseCase{
    
    var nwService : RequestDataProtocol
    
    init(nwService: RequestDataProtocol) {
        self.nwService = nwService
    }
    
    func getUpComing(handler: @escaping (ApiMovieResponse?) -> Void){
        
        nwService.requestData(url: URLs.Instance.getUpComing(),
                              handler: handler)
    }
}
