//
//  NowPlayingNWService.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 27/09/2024.
//

import Foundation

 
class NowPlayingNWService{
    
    var nwService : RequestDataProtocol 
    
    init(nwService: RequestDataProtocol) {
        self.nwService = nwService
    }
    
    func getNowPlaying(handler: @escaping (NowPlayingResponse?) -> Void){
        
        nwService.requestData(url: URLs.Instance.getNowPlaying(),
                              handler: handler)
    }
}
