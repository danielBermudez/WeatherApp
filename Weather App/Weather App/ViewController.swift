//
//  ViewController.swift
//  Weather App
//
//  Created by Daniel Bermudez on 4/4/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 let requests = ResquestTest()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getRequestButton(_ sender: Any) {
        requests.getRequest()
    }
}

