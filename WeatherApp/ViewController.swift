//
//  ViewController.swift
//  WeatherApp
//
//  Created by Перегудова Кристина on 23/12/2019.
//  Copyright © 2019 perekrist. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    struct City {
        var name: String
        var lat: Double
        var lng: Double
    }
    var cities: [City] = [City(name: "Tomsk", lat: 56.501041, lng: 84.992455), City(name: "Moscow", lat: 55.755825, lng: 37.617298),
    City(name: "Saint Petersburg", lat: 59.934280, lng: 30.335098),
    City(name: "London", lat: 51.507351, lng: -0.127758),
    City(name: "Paris", lat: 48.856613, lng: 2.352222)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AF.request("https://api.darksky.net/forecast/49ef1022ff316233b7ba6be47faa13e6/\(cities[0].lat),\(cities[0].lng)").response { response in
            debugPrint(response)
        }
    }


}

