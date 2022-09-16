//
//  WeatherData.swift
//  Clima
//
//  Created by Amirzhan Armandiyev on 14.06.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
}
