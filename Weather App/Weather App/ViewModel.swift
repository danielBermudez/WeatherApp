//
//  ViewModel.swift
//  Weather App
//
//  Created by Daniel Bermudez on 4/8/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import Foundation
class ViewModel{
    let request = Request()
    var cityNameList = ["Bogota","Tokyo"]
    var cityModelList = [CityModel]()
   
    func getDataFromRequest(completionHandler: @escaping (([Data])-> Void)){
         var data = [Data]()
        request.getRequest(cities: cityNameList, completionHandler: {dataSet in
            if let dataSet = dataSet{
                data.append(dataSet)
            }
            if data.count == self.cityNameList.count {
                completionHandler(data)
                
            }
            
        })
      
        
    }
    func convertDataToModel(completionHandler : @escaping (() -> Void)){
        getDataFromRequest(completionHandler: { data in
            for dataSet in data{
                do {
                    let decoder = JSONDecoder()
                    
                    let wheatherViewModel = WeatherViewModel()
                    let weatherJson = try decoder.decode(WeatherViewModel.weather.self, from: dataSet)
                    let wheatherModel =   wheatherViewModel.createWeatherModel(weather: weatherJson)
                    var city = try decoder.decode(CityModel.self, from: dataSet)
                    city.weather = wheatherModel
                    self.cityModelList.append(city)
                    
                } catch {
                    print (error)
                }
            }
            completionHandler()
        })
    }
    
    
    
    
}
