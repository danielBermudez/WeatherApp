//
//  CustomCollectionViewController.swift
//  Weather App
//
//  Created by Daniel Bermudez on 4/8/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

let fontColor =  UIColor(hue: 0.6222, saturation: 0.74, brightness: 0.51, alpha: 1.0)

class CustomCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let requests = Request()
    let viewModel = ViewModel()
    private let weatherCellIdentifier = "weatherCell"

    var sizeCounter = 0
    var delegate : weatherDetailViewDelegate?
    var cityModelList = [CityModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        loadData()
        setAddBarButton()
        self.collectionView!.register(WeatherCell.self, forCellWithReuseIdentifier: weatherCellIdentifier)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        sizeCounter = 0
        self.collectionViewLayout.invalidateLayout()
    }
    
    private func loadData() {
        viewModel.convertDataSetToModel(completionHandler: {
            DispatchQueue.main.async {
                self.cityModelList = self.viewModel.cityModelList
                self.sizeCounter = 0
                self.collectionView.reloadData()
            }
        })
    }
    
    private func setAddBarButton() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:
            #selector(showAddCityPopup))
        navigationController?.navigationBar.tintColor = fontColor
        navigationItem.rightBarButtonItem = addItem
    }
    
    @objc private func showAddCityPopup() {
        let popupViewController = PopUpViewController()
        popupViewController.delegate = self
        popupViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(popupViewController,animated: true)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityModelList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        sizeCounter = sizeCounter + 1
        
        if sizeCounter % 3 == 0 {
            return CGSize(width:view.frame.width, height:150)
        } else {
            return CGSize(width:(view.frame.width / 2.09), height:200)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weatherCellIdentifier, for: indexPath) as! WeatherCell
        cell.cityLabel.text = cityModelList[indexPath.item].name
        cell.degreeLabel.text =  "\(String(format: "%.2f",cityModelList[indexPath.item].weather!.temperature))  °C"
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = DetailWeatherViewController()
        self.navigationController?.pushViewController(detail, animated: true)
        detail.loadCityModel(city: cityModelList[indexPath.item])
    }
    
}

extension CustomCollectionViewController :addCityViewDelegate {
    
    func updateCollectionView(){
        sizeCounter = 0
        let indexPath = IndexPath(row: self.cityModelList.count, section: 0)
        self.cityModelList = self.viewModel.cityModelList
        self.collectionView?.insertItems(at: [indexPath])    }
    
    func addCity(cityName: String,completionHandler :  @escaping (Bool) -> Void ) {
        
        viewModel.testCity(cityName: cityName, completionHandler: {validation in
        
            if validation == true {
                self.viewModel.addCity(cityName: cityName, completionHandler: {
                    DispatchQueue.main.async {
                        self.updateCollectionView()
                    }
                })
                
            }
            completionHandler(validation)
            
        })
    }
    
    
}
protocol weatherDetailViewDelegate {
    func loadCityModel(city :CityModel)
}

class WeatherCell: UICollectionViewCell {
    
    let cityLabel = UILabel()
    let degreeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    func setupView(){
        let yellow = UIColor(hue: 0.1111, saturation: 0.83, brightness: 0.76, alpha: 1.0)
        let orange = UIColor(hue: 0.0778, saturation: 0.83, brightness: 0.76, alpha: 1.0)
        let blue = UIColor(red: 0.0863, green: 0.4235, blue: 0.4706, alpha: 1.0)
        let colors = [UIColor.lightGray,orange,yellow,blue]
        backgroundColor = colors.randomElement()
        setupCityLabel()
        setupDegreeLabel()
        setupCityLabelConstraints()
        setupDegreeLabelConstraints()
        
    }
    
    private func setupCityLabel() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        cityLabel.textColor = fontColor
        addSubview(cityLabel)
    }
    
    private func setupDegreeLabel() {
        degreeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        degreeLabel.translatesAutoresizingMaskIntoConstraints = false
        degreeLabel.textColor = fontColor
        addSubview(degreeLabel)
        
    }
    
    private func setupCityLabelConstraints() {
        NSLayoutConstraint.activate(
            [
                cityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                cityLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            ])
    }
    
    private func setupDegreeLabelConstraints() {
        NSLayoutConstraint.activate(
            [
                degreeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
                degreeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

