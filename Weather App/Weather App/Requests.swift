//
//  Requests.swift
//  Weather App
//
//  Created by Daniel Bermudez on 4/4/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import Foundation

struct Request{
    
    
    func getRequests(cities : [String],completionHandler: @escaping (Data?) -> Void){
        for cityName in cities {
            getSingleRequest(cityName: cityName, completionHandler: { (data) in
                 completionHandler(data)
                })
        }
    }
    
    func getSingleRequest(cityName: String,completionHandler: @escaping (Data?) -> Void){
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&APPID=27ceddda81acd990a193110188a0afe8")
            else {
                return
        }
        let session = URLSession.shared
        session.dataTask(with: url){ (data,response,error) in
            if let data = data {
                completionHandler(data)
            }
            }.resume()
    }
    
    func testCity(cityName :String ,completionHandler: @escaping (Data) -> Void){
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&APPID=27ceddda81acd990a193110188a0afe8")
            else
        {
            return
        }
        let session = URLSession.shared
        session.dataTask(with: url){ (data,response,error) in
            if let data = data {
                completionHandler(data)
            }
            }.resume()
    }
    
}





