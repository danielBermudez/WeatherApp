//
//  Requests.swift
//  Weather App
//
//  Created by Daniel Bermudez on 4/4/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import Foundation

struct Request{
    
    
    func getRequest(cities : [String]) -> [Data]?{
       var dataSet = [Data]()
        for cityName in cities {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&APPID=27ceddda81acd990a193110188a0afe8")
            else
        {
            return nil
        }
      
        let session = URLSession.shared
        session.dataTask(with: url){ (data,response,error) in
            
            
            if let data = data {
                
                
                
//              let json = try JSONSerialization.jsonObject(with: data, options: [])
//              print(json)
                dataSet.append(data)
               
                
           
            }
            }.resume()
        
        }
        return dataSet
        
    }
    
}

    
    
    

