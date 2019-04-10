//
//  popUpViewController.swift
//  Weather App
//
//  Created by Daniel Bermudez on 4/10/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController, UITextFieldDelegate {
    private var customView: UIView!
    var cityTextField = UITextField()
    var delegate : addCityDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setCustomView()
        setAddCityButton()
        setTextField()
        self.customView.backgroundColor = .lightGray
        setCancelButton()
        
        // any other objects should be tied to this view as superView
        // for example adding this okayButton
        
        
    }
    
    private func setCustomView(){
        let customViewFrame = CGRect(x: 0  , y: view.frame.height / 5, width: view.frame.width, height: 100 )
        customView = UIView(frame: customViewFrame)
        customView.backgroundColor = .white
        view.addSubview(customView)
        self.view.addSubview(customView)
        customView.isHidden = false
    }
    
    private func setAddCityButton(){
        
        let addCityFrame = CGRect(x: customView.frame.width / 2, y: customView.frame.height - 50 , width: view.frame.width / 2 , height: 50)
        let addCityButton = UIButton(frame: addCityFrame)
        addCityButton.backgroundColor = .gray
        let color = UIColor.blue
        let colorAttribute = [NSAttributedString.Key.foregroundColor : color]
        let title = NSAttributedString(string: NSLocalizedString("AddCity", comment: ""), attributes: colorAttribute)
        addCityButton.setAttributedTitle(title, for: .normal)
        addCityButton.addTarget(self, action: #selector(addcity) , for: .touchUpInside)
        customView.addSubview(addCityButton)
        
        
    }
    private func setCancelButton(){
        
        let addCityFrame = CGRect(x: 0, y: customView.frame.height - 50 , width: view.frame.width / 2 , height: 50)
        let cancelButton = UIButton(frame: addCityFrame)
        cancelButton.backgroundColor = .gray
        let color = UIColor.blue
        let colorAttribute = [NSAttributedString.Key.foregroundColor : color]
        let title = NSAttributedString(string: NSLocalizedString("Cancel", comment: ""), attributes: colorAttribute)
        cancelButton.setAttributedTitle(title, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancel) , for: .touchUpInside)
        customView.addSubview(cancelButton)
        
        
    }
    @objc func  cancel(){
     self.dismiss(animated: true, completion: nil)
    }
    @objc private func addcity(){
       let text = cityTextField.text!.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
       
        delegate?.addCity(cityName: text , completionHandler: { result in
            DispatchQueue.main.async {
                var alert: UIAlertController
                if result {
                    alert = UIAlertController(title: NSLocalizedString("CityAdded", comment: ""), message: nil, preferredStyle: .alert)
                    self.dismiss(animated: true, completion: nil)
                }else {
                     alert = UIAlertController(title: NSLocalizedString("CityNotFound", comment: ""), message: nil, preferredStyle: .alert)
                    
                }
                let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                    alert.dismiss(animated: true, completion: nil)
                    
                }
                alert.addAction(action1)
                self.present(alert, animated: true)
               
                
                            }
        } )
    
    }
    private func setTextField(){
        cityTextField = UITextField(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        cityTextField.borderStyle = UITextField.BorderStyle.roundedRect
        cityTextField.keyboardType = UIKeyboardType.default
        cityTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        cityTextField.delegate = self
        customView.addSubview(cityTextField)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
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
protocol addCityDelegate{
    func addCity(cityName: String, completionHandler: @escaping (Bool) -> Void  )
}
