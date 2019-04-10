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
    let citiesKey = "citiesarray"
    var cityNameList = [String]()
    var cityModelList = [CityModel]()
    init() {
        loadCitynames()
    }
   
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
    func loadCitynames(){
        let initialCities =  ["Bogota","Tokyo","kyoto","Cali","Pasto","Tampa","Orlando","Atlanta","Barranquilla","Pereira"]
        UserDefaults.standard.register(defaults: [
            citiesKey : initialCities ] )
        cityNameList = UserDefaults.standard.value(forKey: citiesKey) as! [String]
    }
    func updateModel(){
        cityModelList.removeAll()
        convertDataToModel(completionHandler: {})
    }
    func addCity(cityName : String){
        if !cityNameList.contains(cityName){
        cityNameList.append(cityName)
    UserDefaults.standard.setValue(cityNameList , forKey: citiesKey)
        }
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
    
    func testCity(cityName : String, completionHandler : @escaping (Bool) -> Void ) {
        struct error : Codable{
            let code : String
            private enum CodingKeys:String,CodingKey{
                case code = "cod"
            }
        }
        let decoder = JSONDecoder()
        request.testCity(cityName: cityName, completionHandler: { (data) in
               do {
                let error = try  decoder.decode(error.self, from: data)
                print (error.code)
               completionHandler(false)
        } catch {
           completionHandler(true)
        }
            })
   
    }
    
    
    
}
