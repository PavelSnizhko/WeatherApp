//
//  DetailWeatherViewModel.swift
//  WeatherApp
//
//  Created by Павел Снижко on 23.03.2021.
//

import Foundation

class DetailWeatherViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeather
    let city: City?
    
    init(currentWeather: CurrentWeather, city: City?) {
        self.currentWeather = currentWeather
        self.city = city
    }
}

