//
//  popUpViewController.swift
//  Weather App
//
//  Created by Daniel Bermudez on 4/10/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController, UITextFieldDelegate {
     let fontColor =  UIColor(hue: 0.6222, saturation: 0.74, brightness: 0.51, alpha: 1.0)
    private var customView: UIView!
    var cityTextField = UITextField()
    var delegate : addCityViewDelegate!
    let addCityButton = UIButton()
    let cancelButton = UIButton()
    var verticalStackview = UIStackView()
    var horizontalStackview = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setTransparency()
        setCustomView()
    }
    
    private func setHorizontalStackview() {
        let buttonArray = [cancelButton,addCityButton]
        horizontalStackview = UIStackView(arrangedSubviews: buttonArray)
        horizontalStackview.axis = .horizontal
        horizontalStackview.distribution = .fillEqually
        horizontalStackview.alignment = .fill
        horizontalStackview.spacing = 0
        horizontalStackview.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setVerticalStackview() {
        let verticalArray = [cityTextField,horizontalStackview]
        verticalStackview = UIStackView(arrangedSubviews: verticalArray)
        verticalStackview.axis = .vertical
        verticalStackview.distribution = .fillEqually
        verticalStackview.alignment = .fill
        verticalStackview.spacing = 0
        verticalStackview.translatesAutoresizingMaskIntoConstraints = false
        customView.addSubview( verticalStackview)
    }
    
    private func setStackviewConstraints() {
        verticalStackview.heightAnchor.constraint(equalToConstant: 100 ).isActive = true
        verticalStackview.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        verticalStackview.topAnchor.constraint(equalTo: customView.topAnchor).isActive = true
    }
    
    private func setTransparency() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurEffectView)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.customView.removeConstraints(self.customView.constraints)
        setCustomViewConstraints()
        verticalStackview.removeFromSuperview()
        setVerticalStackview()
        setStackviewConstraints()
    }
    
    private func setCustomViewConstraints() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 100 ).isActive = true
        customView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        customView.topAnchor.constraint(equalTo:view.topAnchor,constant: view.frame.height / 6).isActive = true
        customView.backgroundColor = .white
        
    }
    
    private func setCustomView() {
        customView = UIView()
        view.addSubview(customView)
        setCustomViewConstraints()
        setTextField()
        setAddCityButton()
        setCancelButton()
        setHorizontalStackview()
        setVerticalStackview()
        setStackviewConstraints()
    }
    
    private func setAddCityButton() {
        addCityButton.backgroundColor = .lightGray
        let color = fontColor
        let colorAttribute = [NSAttributedString.Key.foregroundColor : color]
        let title = NSAttributedString(string: NSLocalizedString("AddCity", comment: ""), attributes: colorAttribute)
        addCityButton.setAttributedTitle(title, for: .normal)
        addCityButton.addTarget(self, action: #selector(addcity) , for: .touchUpInside)
        customView.addSubview(addCityButton)
    }
    
    private func setCancelButton() {
        cancelButton.backgroundColor = .gray
        let color = fontColor
        let colorAttribute = [NSAttributedString.Key.foregroundColor : color]
        let title = NSAttributedString(string: NSLocalizedString("Cancel", comment: ""), attributes: colorAttribute)
        cancelButton.setAttributedTitle(title, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancel) , for: .touchUpInside)
        customView.addSubview(cancelButton)
    }
    
    @objc func  cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func addcity() {
        let text = cityTextField.text!.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        delegate?.addCity(cityName: text , completionHandler: { result in
            DispatchQueue.main.async {
                var cityFoundalert: UIAlertController
                if result {
                    cityFoundalert = UIAlertController(title: NSLocalizedString("CityAdded", comment: ""), message: nil, preferredStyle: .alert)
                    self.dismiss(animated: true, completion: nil)
                }else {
                    cityFoundalert = UIAlertController(title: NSLocalizedString("CityNotFound", comment: ""), message: nil, preferredStyle: .alert)
                    
                }
                let dismissAlert = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                    cityFoundalert.dismiss(animated: true, completion: nil)
                    
                }
                cityFoundalert.addAction(dismissAlert)
                self.present(cityFoundalert, animated: true)
            }
        } )
    }
    
    private func setTextField() {
        cityTextField = UITextField()
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
    
}

protocol addCityViewDelegate {    
    func addCity(cityName: String, completionHandler: @escaping (Bool) -> Void  )
}
