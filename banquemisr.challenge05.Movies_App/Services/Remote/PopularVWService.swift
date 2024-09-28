//
//  PopularVWService.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 28/09/2024.
//

import Foundation

class PopularNWService{
    
    var nwService : RequestDataProtocol
    
    init(nwService: RequestDataProtocol) {
        self.nwService = nwService
    }
    
    func getPopular(handler: @escaping (PopularResponse?) -> Void){
        
        nwService.requestData(url: URLs.Instance.getPopular(),
                              handler: handler)
    }
}
