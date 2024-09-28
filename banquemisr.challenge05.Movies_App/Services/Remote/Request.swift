//
//  Request.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 28/09/2024.
//

import Foundation

protocol RequestDataProtocol{
    func requestData<T: Decodable>(url : String, handler: @escaping (T?) -> Void)
}

class RequestData: RequestDataProtocol{
    
    func requestData<T: Decodable>(url : String, handler: @escaping (T?) -> Void){
        
        let url = URL(string: url)
        guard let url = url else{return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNDIwMTI2ZWIzOGUxN2U0Yjg0NzUwZGM3ZTQ2ODA3MiIsIm5iZiI6MTcyNzQ3MTc1OS41NzEzMTksInN1YiI6IjY2ZjcxYmY3MGViN2RjODBjMWMwN2EyZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.4Wgko5Wqs-MshnLqEIX6GOxt9TiU8uP0x23Jp5MEoBw"
        ]
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request){ data , response , error in
            guard let data = data else {
                print("No data received")
                return
            }
            do{
                let comingData = try JSONDecoder().decode(T.self, from: data)
                // self.NowPlayinglist = comingData.results ?? [NowPlaying()]
                handler(comingData)
                
            }catch{
                print(error)
                
            }
        }
        task.resume()
    }
}



class URLs {
    static let Instance = URLs()
    private init() {}
    
    let baseUrl = "https://api.themoviedb.org/3/movie/"
    
    func getNowPlaying() -> String {
        baseUrl + "now_playing?language=en-US&page=1"
    }
    
    func getPopular() -> String {
        baseUrl + "popular?language=en-US&page=1"
    }
    
    func getUpComing() -> String {
        baseUrl + "upcoming?language=en-US&page=1"
    }
}
