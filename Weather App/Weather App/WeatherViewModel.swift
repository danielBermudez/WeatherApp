//
//  WeatherViewModel.swift
//  Weather App
//
//  Created by Daniel Bermudez on 4/8/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import Foundation
class WeatherViewModel{
    
    struct weather :Codable {
        let main : main
        let wind: wind
        let clouds : clouds
        
    }
    
    struct main : Codable {
        let temperature : Double
        let humidity :Int
        let pressure: Int
        private enum CodingKeys:String,CodingKey{
            case temperature = "temp",humidity = "humidity", pressure = "pressure"
        }
    }
    
    struct wind : Codable {
        let speed : Double
        private enum CodingKeys:String,CodingKey{
            case speed = "speed"
        }
    }
    
    struct clouds : Codable {
        let all : Int
        private enum CodingKeys:String,CodingKey{
            case all = "all"
        }
    }
    
    func createWeatherModel(weather: weather) -> WeatherModel {
        return WeatherModel(temperature: (weather.main.temperature - 273.15), wind: weather.wind.speed, cloudiness: weather.clouds.all, pressure: weather.main.pressure, humidity: weather.main.humidity)
    }
    
}
