//
//  CurrentWeather.swift
//  ForecastApp
//
//  Created by 전혜성 on 2022/01/30.
//

import Foundation

struct CurrentWeather: Codable {
    let dt: Int
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    let weather: [Weather]
    
    struct Main: Codable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
        
    }
    
    let main: Main
}
