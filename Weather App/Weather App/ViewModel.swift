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
        loadSavedData()
    }
    
    func getDataFromRequests(completionHandler: @escaping (([Data])-> Void)) {
        var data = [Data]()
        request.getRequests(cities: cityNameList, completionHandler: {dataSet in
            if let dataSet = dataSet{
                data.append(dataSet)
            }
            if data.count == self.cityNameList.count {
                completionHandler(data)
            }
        })
    }
    
    func convertDataSetToModel(completionHandler : @escaping (() -> Void)) {
        getDataFromRequests(completionHandler: { data in
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
    func getNewCityData(cityName : String,completionHandler: @escaping ((Data)-> Void)){
        request.getSingleRequest(cityName: cityName, completionHandler: {data in
            completionHandler(data!)
        })
    }
    
    func convertNewCityDataToModel(cityName : String,completionHandler: @escaping ((CityModel)-> Void)) {
        getNewCityData(cityName: cityName, completionHandler: {data in
            do {
                let decoder = JSONDecoder()
                let wheatherViewModel = WeatherViewModel()
                let weatherJson = try decoder.decode(WeatherViewModel.weather.self, from: data)
                let wheatherModel =   wheatherViewModel.createWeatherModel(weather: weatherJson)
                var city = try decoder.decode(CityModel.self, from: data)
                city.weather = wheatherModel
                completionHandler(city)
            } catch {
                print (error)
            }
        })
        
    }
    
    private func loadInitialDataIfNoDataExist() {
        let initialCities =  ["Bogota","Tokyo","kyoto","Cali","Pasto","Tampa","Orlando","Atlanta","Barranquilla","Pereira"]
        UserDefaults.standard.register(defaults: [
            citiesKey : initialCities ] )
    }
    
    func loadSavedData() {
        loadInitialDataIfNoDataExist()
        cityNameList = UserDefaults.standard.value(forKey: citiesKey) as! [String]
    }
    
    func addCity(cityName : String, completionHandler : @escaping () -> Void) {
        if !cityNameList.contains(cityName){
            cityNameList.append(cityName)
            UserDefaults.standard.setValue(cityNameList , forKey: citiesKey)
            convertNewCityDataToModel(cityName: cityName, completionHandler: { (city) in
                self.cityModelList.append(city)
                 completionHandler()
                })
        }
    }
    
    func testCity(cityName : String, completionHandler : @escaping (Bool) -> Void ) {
        struct error : Codable {
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
