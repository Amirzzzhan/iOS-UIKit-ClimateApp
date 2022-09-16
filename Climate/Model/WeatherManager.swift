//
//  WhetherManager.swift
//  Clima
//
//  Created by Amirzhan Armandiyev on 14.06.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=d7979ed4bbf1d838a9bef4e060897c4c&units=metric&q="
    let weatherURLByLocation = "https://api.openweathermap.org/data/2.5/weather?appid=d7979ed4bbf1d838a9bef4e060897c4c&units=metric&"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let url = "\(weatherURL)\(cityName)"
        performRequest(url)
    }
    
    func fetchWeatherByLocation(lat: Double, lon: Double) {
        let url = "\(weatherURLByLocation)lat=\(lat)&lon=\(lon)"
        performRequest(url)
    }
    
    func performRequest(_ urlString: String) {
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weatherModel = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weatherModel
        } catch {
            print(error)
            return nil
        }
    }
}


//func performRequest(urlString: String) {
//    if let url = URL(string: urlString) {
//        let session = URLSession(configuration: .default)
//
//        let task = session.dataTask(with: url) { data, responce, err in
//            if err != nil {
//                return
//            }
//
//            if let safeData = data {
//                let decoder = JSONDecoder()
//
//                do {
//                    let decodedData = try decoder.decode(MyClass.self, from: safeData)
//
//                    decodeData
//
//                } catch {
//                    return
//                }
//            }
//        }
//    }
//
//
//}
