//
//  CustomCollectionViewController.swift
//  Weather App
//
//  Created by Daniel Bermudez on 4/8/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

private let weatherCellIdentifier = "weatherCell"


let viewModel = ViewModel()
var cityModelList = [CityModel]()

class CustomCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let requests = Request()
    var sizeCounter = 0
    var delegate : DetailDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        loadData()
        setAddBarButton()
        
       
        // Do any additional setup after loading the view.
        self.collectionView!.register(WeatherCell.self, forCellWithReuseIdentifier: weatherCellIdentifier)
        
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionViewLayout.invalidateLayout()
    }
    
      
    
    private func loadData(){
        
        viewModel.convertDataToModel(completionHandler: {
            DispatchQueue.main.async {
                cityModelList = viewModel.cityModelList
                self.collectionView.reloadData()
            }
        })
    }
    
    private func setAddBarButton(){
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddCityPopup))
        navigationItem.rightBarButtonItem = addItem
    }
    
    @objc private func showAddCityPopup(){
        
        let popupViewController = PopUpViewController()
        popupViewController.delegate = self
        popupViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(popupViewController,animated: true)
        
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return cityModelList.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        sizeCounter = (sizeCounter + 1)
        if sizeCounter % 3 == 0 {
            return CGSize(width: view.frame.width   , height: 150)
        }else {
            return CGSize(width: view.frame.width  / 2.1 , height: 200)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weatherCellIdentifier, for: indexPath) as! WeatherCell
        cell.cityLabel.text = cityModelList[indexPath.item].name
        cell.degreeLabel.text =  "\(cityModelList[indexPath.item].weather!.temperature) K"
        
        // Configure the cell
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return true
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }*/
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = DetailWeatherViewController()
        self.navigationController?.pushViewController(detail, animated: true)
        detail.loadCityModel(city: cityModelList[indexPath.item])
    }
    
}
class WeatherCell: UICollectionViewCell{
    
    let cityLabel = UILabel()
    let degreeLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    func setupView(){
        let colors = [UIColor.orange,.green,.cyan,.yellow]
        backgroundColor = colors.randomElement()
        cityLabel.text = "Bogota"
        degreeLabel.text = "0 °C"
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        cityLabel.textColor = UIColor.blue
        degreeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        degreeLabel.translatesAutoresizingMaskIntoConstraints = false
        degreeLabel.textColor = UIColor.blue
        addSubview(cityLabel)
        addSubview(degreeLabel)
        NSLayoutConstraint.activate(
            [
            cityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            cityLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                degreeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
                degreeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
            
        ])
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension CustomCollectionViewController :addCityDelegate{
    func updateViewCollection(){
        viewModel.cityModelList.removeAll()
        
        loadData()
        
    }
    func addCity(cityName: String,completionHandler :  @escaping (Bool) -> Void ) {
        
        viewModel.testCity(cityName: cityName, completionHandler: {validation in
            DispatchQueue.main.async {
                
                if validation == true {
                    viewModel.addCity(cityName: cityName)
                    self.updateViewCollection()
                }
                completionHandler(validation)
            }
        })
    }
    
    
}
protocol DetailDelegate {
    func loadCityModel(city :CityModel)
}
