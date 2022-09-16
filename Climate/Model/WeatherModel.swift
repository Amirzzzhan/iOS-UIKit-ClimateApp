//
//  WeatherModel.swift
//  Clima
//
//  Created by Amirzhan Armandiyev on 14.06.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var conditionName: String {
        switch conditionID {
            case 200..<300: return "cloud.bolt"
            case 300..<400: return "cloud.drizzle"
            case 500..<600: return "cloud.rain"
            case 600..<700: return "cloud.snow"
            case 700..<800: return "cloud.fog"
            case 800: return "sun.max"
            default: return "cloud.bolt"
        }
    }
    
    var temperatureString: String {
        String(format: "%.1f", temperature)
    }
    
}
