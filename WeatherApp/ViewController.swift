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

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    var days: [Day] = [ Day(day: "WED", image: UIImage(named: "snow"), temp: "10"),
                       Day(day: "SAT", image: UIImage(named: "cloud"), temp: "16"),
                       Day(day: "TUE", image: UIImage(named: "sunny"), temp: "6"),
                       Day(day: "FRI", image: UIImage(named: "storm"), temp: "12"),
                       Day(day: "MON", image: UIImage(named: "rain"), temp: "8") ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.image.image = days[indexPath.row].image
        cell.day.text = days[indexPath.row].day
        cell.degrees.text = days[indexPath.row].temp + "°"
        return cell
    }
    
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
    
    struct Day {
        var day: String
        var image: UIImage?
        var temp: String
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
                        print(jsonData)
                        let currentData = jsonData["currently"]
                        let currentTemp = currentData["apparentTemperature"]
                        self.label.text = "\(currentTemp)" + "°F"
                    case .failure(let error):
                        print(error)
                    }
                }
    }

}



