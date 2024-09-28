//
//  UpComingNWService.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 28/09/2024.
//

import Foundation

class UpComingNWService{
    
    var nwService : RequestDataProtocol
    
    init(nwService: RequestDataProtocol) {
        self.nwService = nwService
    }
    
    func getUpComing(handler: @escaping (UpComingResponse?) -> Void){
        
        nwService.requestData(url: URLs.Instance.getUpComing(),
                              handler: handler)
    }
}
