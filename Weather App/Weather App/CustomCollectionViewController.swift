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

class CustomCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let requests = Request()
    var sizeCounter = 0
   var delegate : DetailDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        viewModel.convertDataToModel(completionHandler: {
            DispatchQueue.main.async {
                 self.collectionView.reloadData()
            }
           
        })
       
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        view.addSubview(navBar)
        let navItem = UINavigationItem(title: "SomeTitle")
        navBar.setItems([navItem], animated: false) 
        // Register cell classes
        self.collectionView!.register(WeatherCell.self, forCellWithReuseIdentifier: weatherCellIdentifier)

        // Do any additional setup after loading the view.
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
        return viewModel.cityModelList.count
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
        cell.cityLabel.text = viewModel.cityModelList[indexPath.item].name
        cell.degreeLabel.text =  String(viewModel.cityModelList[indexPath.item].weather!.temperature)
    
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
            detail.loadCityModel(city: viewModel.cityModelList[indexPath.item])
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
        degreeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        degreeLabel.translatesAutoresizingMaskIntoConstraints = false
        degreeLabel.textColor = UIColor.blue
        addSubview(cityLabel)
        addSubview(degreeLabel)
        NSLayoutConstraint.activate(
            [
            cityLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -(self.bounds.width / 3)),
             cityLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -(self.bounds.height / 3)),
          degreeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: self.bounds.width / 3),
            degreeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: self.bounds.height / 3)]
        )
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
protocol DetailDelegate {
    func loadCityModel(city :CityModel)
}
