//
//  DetailWeatherViewController.swift
//  Weather App
//
//  Created by Daniel Bermudez on 4/9/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class DetailWeatherViewController: UIViewController {
    let fontColor =  UIColor(hue: 0.6222, saturation: 0.74, brightness: 0.51, alpha: 1.0)
    let viewModel = ViewModel()
    let cityLabel = UILabel()
    let latitudeLabel = UILabel()
    let longitudeLabel = UILabel()
    let temperatureLabel = UILabel()
    let windLabel = UILabel()
    let cloudinessLabel = UILabel()
    let pressureLabel = UILabel()
    let humidityLabel = UILabel()
    var scrollView = UIScrollView()
    var labelArray = [UILabel]()
    var stackview = UIStackView()
    var contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        configureContentView()
        setupLabels()
        setupConstraints()
        
        
    }
    
    
    
    
    private func setupLabels() {
        setupCityLabel()
        setupTemperatureLabel()
        setupLatitudeAndLongitudeStackview()
        setupWindLabel()
        setupCloudinessLabel()
        setupPressureLabel()
        setupHumidityLabel()
        
    }
    
    private func setupConstraints() {
        configureContentViewConstraints()
        setupCityConstraints()
        setupTemperatureConstraints()
        setupLatitudeAndLongitudeStackviewConstraints()
        setupWindConstraints()
        setupCloudinessConstraints()
        setupPressureConstraints()
        setupHumidityConstraints()
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.contentView.removeConstraints(self.contentView.constraints)
        setupConstraints()
    }
    
    private func configureContentView(){
        contentView = UIView()
        scrollView = UIScrollView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    private func configureContentViewConstraints(){
        scrollView.contentSize = CGSize(width: self.view.frame.width + 10  , height:self.view.frame.height + 10)
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        
    }
    
    private func setupCityLabel() {
        cityLabel.textColor = fontColor
        cityLabel.font = UIFont(name: "Futura", size: 50)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTemperatureLabel() {
        temperatureLabel.textColor = fontColor
        temperatureLabel.font = UIFont(name: "Futura", size: 40)
    }
    
    private func setupLatitudeAndLongitudeStackview() {
        setupLatitudeLabel()
        setupLongitudeLabel()
        labelArray = [latitudeLabel,longitudeLabel]
        stackview = UIStackView(arrangedSubviews: labelArray)
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.alignment = .fill
        stackview.spacing = 5
        stackview.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLatitudeLabel() {
        latitudeLabel.textColor = fontColor
        latitudeLabel.font = UIFont(name: "Futura", size: 20)
    }
    
    private func setupLongitudeLabel() {
        longitudeLabel.textColor = fontColor
        longitudeLabel.font = UIFont(name: "Futura", size: 20)
    }
    
    private func setupWindLabel() {
        windLabel.textColor = fontColor
        windLabel.font = UIFont(name: "Futura", size: 25)
        windLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupCloudinessLabel() {
        cloudinessLabel.textColor = fontColor
        cloudinessLabel.font = UIFont(name: "Futura", size: 30)
        cloudinessLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupPressureLabel() {
        pressureLabel.textColor = fontColor
        pressureLabel.font = UIFont(name: "Futura", size: 30)
    }
    
    private func setupHumidityLabel() {
        humidityLabel.textColor = fontColor
        humidityLabel.font = UIFont(name: "Futura", size: 30)
    }
    
    private func setupCityConstraints() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(cityLabel)
        if (self.contentView.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.compact){
            self.cityLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 40 ).isActive = true
        }else {
            self.cityLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 100 ).isActive = true
        }
        cityLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    }
    
    private func setupTemperatureConstraints() {
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(temperatureLabel)
        temperatureLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: self.cityLabel.bottomAnchor, constant: 0 ).isActive = true
    }
    
    private func setupLatitudeAndLongitudeStackviewConstraints() {
        stackview.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(stackview)
        stackview.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        stackview.topAnchor.constraint(equalTo: self.temperatureLabel.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupWindConstraints() {
        windLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(windLabel)
        windLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        windLabel.topAnchor.constraint(equalTo: self.stackview.bottomAnchor , constant: 0 ).isActive = true
    }
    
    private func setupCloudinessConstraints() {
        cloudinessLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview( cloudinessLabel)
        cloudinessLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        cloudinessLabel.topAnchor.constraint(equalTo: self.windLabel.bottomAnchor, constant: 0 ).isActive = true
    }
    
    private func setupPressureConstraints() {
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview( pressureLabel)
        pressureLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        pressureLabel.topAnchor.constraint(equalTo: self.cloudinessLabel.bottomAnchor, constant: 0 ).isActive = true
    }
    
    private func setupHumidityConstraints() {
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview( humidityLabel)
        humidityLabel.centerXAnchor.constraint(equalTo:self.contentView.centerXAnchor).isActive = true
        humidityLabel.topAnchor.constraint(equalTo: self.pressureLabel.bottomAnchor, constant: 0 ).isActive = true
    }
    
}

extension DetailWeatherViewController: weatherDetailViewDelegate {
    
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
