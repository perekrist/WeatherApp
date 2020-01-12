//
//  ViewController.swift
//  WeatherApp
//
//  Created by Перегудова Кристина on 23/12/2019.
//  Copyright © 2019 perekrist. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var currentPosition = 0
    
    @IBOutlet weak var label: UILabel!
    @IBAction func submitBtn(_ sender: Any) {
        makeRequest(position: currentPosition)
    }
    
    @IBOutlet weak var picker: UIPickerView!
    
    struct City {
        var name: String
        var lat: Float
        var lng: Float
    }
    
    var cities: [City] = [City(name: "Tomsk", lat: 56.501041, lng: 84.992455),
                          City(name: "Moscow", lat: 55.755825, lng: 37.617298),
    City(name: "Saint Petersburg", lat: 59.934280, lng: 30.335098),
    City(name: "London", lat: 51.507351, lng: -0.127758),
    City(name: "Paris", lat: 48.856613, lng: 2.352222)]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentPosition = row
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func makeRequest(position: Int) {
         let apikey = "49ef1022ff316233b7ba6be47faa13e6"
        
        AF.request("https://api.darksky.net/forecast/\(apikey)/\(cities[position].lat),\(cities[position].lng)").validate().responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        let jsonData = JSON(data)
                        let currentData = jsonData["currently"]
                        let currentTemp = currentData["apparentTemperature"]
                        self.label.text = "\(currentTemp)"
                    case .failure(let error):
                        print(error)
                    }
                }
    }

}



