//
//  NowPlayingUseCase.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 27/09/2024.
//

import Foundation

class NowPlayingUseCase{
    
    var nwService : RequestDataProtocol 
    
    init(nwService: RequestDataProtocol) {
        self.nwService = nwService
    }
    
    func getNowPlaying(handler: @escaping (ApiMovieResponse?) -> Void){
        
        nwService.requestData(url: URLs.Instance.getNowPlaying(),
                              handler: handler)
        
    }
    
    func saveNowPlayingToCoreData(data: [Movie]){
        CoreDataManager.deleteAllDataThenSave(data: data, entityName: .NowPlayingMovies)
    }
    
    func fetchNowPlayingMoviesFromCoreData() -> [Movie] {
       return CoreDataManager.fetchMoviesFromCoreData(entityName: .NowPlayingMovies)
    }
    
    
}
