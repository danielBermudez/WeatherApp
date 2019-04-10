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
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        // Do any additional setup after loading the view.
       setupLabels()
        
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
    
    private func setupCityLabel(){
        cityLabel.textColor = .white
      cityLabel.font = UIFont(name: "Futura", size: 50)
     
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cityLabel)
        NSLayoutConstraint.activate(
            [
                cityLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                cityLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -(self.view.frame.height / 3))
            ])
        

    }
    private func setupTemperatureLabel(){
        temperatureLabel.textColor = .white
        temperatureLabel.font = UIFont(name: "Futura", size: 40)
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(temperatureLabel)
        NSLayoutConstraint.activate(
            [
               temperatureLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
               temperatureLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -(self.view.frame.height / 4.5))
            ])
       
        
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.view.setNeedsUpdateConstraints()
    }
    private func setupLatitudeAndLongitudeLabels(){
        latitudeLabel.textColor = .white
        latitudeLabel.font = UIFont(name: "Futura", size: 20)
      
        longitudeLabel.textColor = .white
        longitudeLabel.font = UIFont(name: "Futura", size: 20)
       
        let labelArray = [latitudeLabel,longitudeLabel]
        let stackview = UIStackView(arrangedSubviews: labelArray)
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.alignment = .fill
        stackview.spacing = 5
        stackview.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackview)
        NSLayoutConstraint.activate(
            [
                stackview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                stackview.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -(self.view.frame.height / 3.5))
            ])
     
        
    }
    private func setupWindLabel(){
        windLabel.textColor = .white
        windLabel.font = UIFont(name: "Futura", size: 25)
        windLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(windLabel)
        NSLayoutConstraint.activate(
            [
            windLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            windLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -(self.view.frame.height / 6))
            ])
       
        
    }
    private func setupCloudinessLabel(){
        cloudinessLabel.textColor = .white
        cloudinessLabel.font = UIFont(name: "Futura", size: 30)
       cloudinessLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview( cloudinessLabel)
        NSLayoutConstraint.activate(
            [
                 cloudinessLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                cloudinessLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -(self.view.frame.height / 8.7))
            ])
        
    }
    private func setupPressureLabel(){
        pressureLabel.textColor = .white
       pressureLabel.font = UIFont(name: "Futura", size: 30)
       pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview( pressureLabel)
        NSLayoutConstraint.activate(
            [
               pressureLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
               pressureLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -(self.view.frame.height / 17))
            ])
        
    }
    private func setupHumidityLabel(){
        humidityLabel.textColor = .white
        humidityLabel.font = UIFont(name: "Futura", size: 30)
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview( humidityLabel)
        NSLayoutConstraint.activate(
            [
                humidityLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                humidityLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0)
            ])
       
       
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
        temperatureLabel.text = "\(city.weather!.temperature) K"
        windLabel.text = " \(NSLocalizedString("WindSpeed", comment: "")) \(city.weather!.wind) m/s"
        cloudinessLabel.text = " \(NSLocalizedString("Cloudiness", comment: "")) \(city.weather!.cloudiness) % "
        pressureLabel.text = " \(NSLocalizedString("Pressure", comment: "")) \(city.weather!.pressure) hPa"
        humidityLabel.text =  " \(NSLocalizedString("Humidity", comment: ""))  \(city.weather!.humidity) %"
        
        
    }
}
