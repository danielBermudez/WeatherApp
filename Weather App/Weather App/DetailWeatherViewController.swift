//
//  DetailWeatherViewController.swift
//  Weather App
//
//  Created by Daniel Bermudez on 4/9/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class DetailWeatherViewController: UIViewController {
    
    
    let viewModel = ViewModel()
    let cityLabel = UILabel()
    let latitudeLabel = UILabel()
    let longitudeLabel = UILabel()
    let temperatureLabel = UILabel()
    let windLabel = UILabel()
    let cloudinessLabel = UILabel()
    let pressureLabel = UILabel()
    let humidityLabel = UILabel()
    var labelArray = [UILabel]()
    var stackview = UIStackView()
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        // Do any additional setup after loading the view.
       setupLabels()
        setupConstraints()
        
      }
   
    
    private func setupLabels(){
        setupCityLabel()
        setupTemperatureLabel()
        setupLatitudeAndLongitudeLabels()
        setupWindLabel()
        setupCloudinessLabel()
        setupPressureLabel()
        setupHumidityLabel()

    }
    private func setupConstraints(){
        setupCityConstraints()
        setupTemperatureConstraints()
        setupLatitudeAndLongitudeConstraints()
        setupWindConstraints()
        setupCloudinessConstraints()
        setupPressureConstraints()
        setupHumidityConstraints()
        
    }

   
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        self.view.removeConstraints(self.view.constraints)
        setupConstraints()
    }
    
    
    private func setupCityLabel(){
        cityLabel.textColor = .white
      cityLabel.font = UIFont(name: "Futura", size: 50)
     
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        

    }
    private func setupTemperatureLabel(){
        temperatureLabel.textColor = .white
        temperatureLabel.font = UIFont(name: "Futura", size: 40)
        
    }

    private func setupLatitudeAndLongitudeLabels(){
        
        latitudeLabel.textColor = .white
        latitudeLabel.font = UIFont(name: "Futura", size: 20)
        longitudeLabel.textColor = .white
        longitudeLabel.font = UIFont(name: "Futura", size: 20)
       
        labelArray = [latitudeLabel,longitudeLabel]
        stackview = UIStackView(arrangedSubviews: labelArray)
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.alignment = .fill
        stackview.spacing = 5
        stackview.translatesAutoresizingMaskIntoConstraints = false
       
    }
    private func setupWindLabel(){
        windLabel.textColor = .white
        windLabel.font = UIFont(name: "Futura", size: 25)
        windLabel.translatesAutoresizingMaskIntoConstraints = false
        
       
        
    }
    private func setupCloudinessLabel(){
        cloudinessLabel.textColor = .white
        cloudinessLabel.font = UIFont(name: "Futura", size: 30)
       cloudinessLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func setupPressureLabel(){
        pressureLabel.textColor = .white
       pressureLabel.font = UIFont(name: "Futura", size: 30)
       
        
    }
    private func setupHumidityLabel(){
        humidityLabel.textColor = .white
        humidityLabel.font = UIFont(name: "Futura", size: 30)
        
       
    }

    private func setupCityConstraints(){
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cityLabel)
        if (self.view.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.compact){
            self.cityLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40 ).isActive = true
        }else {
            self.cityLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100 ).isActive = true
        }
                cityLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }
    private func setupTemperatureConstraints(){
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(temperatureLabel)
        
                temperatureLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
   
            temperatureLabel.topAnchor.constraint(equalTo: self.cityLabel.bottomAnchor, constant: 0 ).isActive = true
        
        
        
    }
    private func setupLatitudeAndLongitudeConstraints(){
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackview)
       
                stackview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        
            stackview.topAnchor.constraint(equalTo: self.temperatureLabel.bottomAnchor, constant: 0).isActive = true
       
        
        
        
        
    }
    private func setupWindConstraints(){
        windLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(windLabel)
        
                windLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        
            windLabel.topAnchor.constraint(equalTo: self.stackview.bottomAnchor , constant: 0 ).isActive = true
        
        
    }
    private func setupCloudinessConstraints(){
        
        cloudinessLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview( cloudinessLabel)
       
                cloudinessLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
      
            cloudinessLabel.topAnchor.constraint(equalTo: self.windLabel.bottomAnchor, constant: 0 ).isActive = true
    }
    private func setupPressureConstraints(){
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview( pressureLabel)
        
                pressureLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
       
           pressureLabel.topAnchor.constraint(equalTo: self.cloudinessLabel.bottomAnchor, constant: 0 ).isActive = true
      
        
        
    }
    private func setupHumidityConstraints(){
        
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview( humidityLabel)
      
                humidityLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
      
            humidityLabel.topAnchor.constraint(equalTo: self.pressureLabel.bottomAnchor, constant: 0 ).isActive = true
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailWeatherViewController: DetailDelegate{
    func loadCityModel(city: CityModel) {
        cityLabel.text = city.name
        latitudeLabel.text = " \(NSLocalizedString("Latitude", comment: "")) \(city.coordinates.latitude)"
        longitudeLabel.text = " \(NSLocalizedString("Longitude", comment: "")) \(city.coordinates.longitude)"
        temperatureLabel.text = "\(String(format: "%.2f",city.weather!.temperature)) °C"
        windLabel.text = " \(NSLocalizedString("WindSpeed", comment: "")) \(city.weather!.wind) m/s"
        cloudinessLabel.text = " \(NSLocalizedString("Cloudiness", comment: "")) \(city.weather!.cloudiness) % "
        pressureLabel.text = " \(NSLocalizedString("Pressure", comment: "")) \(city.weather!.pressure) hPa"
        humidityLabel.text =  " \(NSLocalizedString("Humidity", comment: ""))  \(city.weather!.humidity) %"
        
        
    }
}
