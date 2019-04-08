//
//  Requests.swift
//  Weather App
//
//  Created by Daniel Bermudez on 4/4/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import Foundation

struct Request{
    
    
    func getRequest(cities : [String]){
        for cityName in cities {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&APPID=27ceddda81acd990a193110188a0afe8")
            else
        {
            return
        }
      
        let session = URLSession.shared
        session.dataTask(with: url){ (data,response,error) in
            
            
            if let data = data {
                
                
                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                                  print(json)
                    let decoder = JSONDecoder()
                    let wheatherViewModel = WeatherViewModel()
                    let weatherTest = try decoder.decode(WeatherViewModel.weather.self, from: data)
                    let finalWheather =   wheatherViewModel.createWeatherModel(weather: weatherTest)                    
                    print(finalWheather.wind)
                    let test = try decoder.decode(CityModel.self, from: data)
                    print(test.name)
                    print(finalWheather.temperature)
                    print("Latitude: \(test.coordinates.latitude)")
                    print("Longitude: \(test.coordinates.longitude)")
                
            } catch {
                print (error)
            }
            }
            }.resume()
        
        }}
    
}

    
    
    

