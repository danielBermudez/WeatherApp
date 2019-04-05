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
        session.dataTask(with: url){ (data,response,error) in
            
            
            if let data = data {
                
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    //                print(json)
                    let decoder = JSONDecoder()
                    let test = try decoder.decode(cityModel.self, from: data)
                    print(test.name)
                    print("Latitude: \(test.coordinates.latitude)")
                    print("Longitude: \(test.coordinates.longitude)")
                
            } catch {
                print (error)
            }
            }
            }.resume()
        
}
}
struct cityModel : Codable {
    let coordinates :Coordinates
    let name   : String
    private enum CodingKeys:String,CodingKey{
        case coordinates = "coord", name = "name"
    }
    
}
struct Coordinates : Codable{
    let latitude : Double
    let longitude : Double
    private enum CodingKeys:String,CodingKey{
        case latitude = "lat",
         longitude = "lon"
    }
}
