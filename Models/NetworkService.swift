//
//  NetworkService.swift
//  NavigTest
//
//  Created by Mac on 07.01.2023.
//

import Foundation

enum AppConfiguration {
    
    case one(String)
    case two( String)
    case three(String)
}

struct NetworkService {
    
    static func request( for configuration: AppConfiguration) {
      
        var urlStr = ""

        switch  configuration {
        case .one("https://swapi.dev/api/starships/3"):
            urlStr = "https://swapi.dev/api/starships/3"
           
            
        case .two( "https://swapi.dev/api/starships/8"):
            urlStr = "https://swapi.dev/api/starships/8"
        
        case .three( "https://swapi.dev/api/planets/5"):
            urlStr = "https://swapi.dev/api/planets/5"
        default: break
        }
        
        let url: URL = URL(string: urlStr)!
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { dat, responce, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if  (responce as! HTTPURLResponse).statusCode != 200 {
                print("STATUS CODE != 200, Status code = \((responce as! HTTPURLResponse).statusCode)")
                return
            }
            
            guard let dat = dat else {
                print("NO DATA")
                return
            }
            
            do {
                let answer = try JSONSerialization.jsonObject(with: dat) as? [String: Any]
                if let data = answer {
                print(data as AnyObject)
                }
            } catch {
                print(error.localizedDescription)
            }
        print("--------------")
           print("Responce status code = \((responce as! HTTPURLResponse).statusCode)")
            print((responce as! HTTPURLResponse).allHeaderFields)
        }
        task.resume()
    }
}



