//
//  Requests.swift
//  Weather App
//
//  Created by Daniel Bermudez on 4/4/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import Foundation

struct ResquestTest{
    
    
    func getRequest(){
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=London&APPID=27ceddda81acd990a193110188a0afe8")
            else
        {
            return
        }
      
        let session = URLSession.shared
        session.dataTask(with: url){(data,response,error) in
            if let response = response {
                print (response)
            }
            
            if let data = data {
                print (data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print (error)
            }
        }
            }.resume()
    }
    
}