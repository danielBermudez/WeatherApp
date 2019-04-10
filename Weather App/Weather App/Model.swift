//
//  Model.swift
//  Weather App
//
//  Created by Daniel Bermudez on 4/8/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import Foundation
struct CityModel : Codable {
    let coordinates :CoordinatesModel
    let name   : String
    var weather : WeatherModel?
    private enum CodingKeys:String,CodingKey{
        case coordinates = "coord", name = "name"
    }
   
}
struct CoordinatesModel : Codable{
    let latitude : Double
    let longitude : Double    
    private enum CodingKeys:String,CodingKey{
        case latitude = "lat",
        longitude = "lon"
    }
}
    struct WeatherModel {
        let temperature:Double
        let wind: Double
        let cloudiness: Int
        let pressure:Int
        let humidity: Int

        
}

