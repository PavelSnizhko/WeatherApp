//
//  CurrentWeatherRowViewModel.swift
//  WeatherApp
//
//  Created by Павел Снижко on 23.03.2021.
//

import Foundation

struct CurrentWeatherRowViewModel {
  private let item: CurrentWeather
  
  var temperature: String {
    return String(format: "%.1f", item.mainWeather.temp)
  }
    
    var temperatureFelsLike: String {
      return String(format: "%.1f", item.mainWeather.feelsLikeTemp)
    }
  
  var maxTemperature: String {
    return String(format: "%.1f", item.mainWeather.tempMax)
  }
  
  var minTemperature: String {
    return String(format: "%.1f", item.mainWeather.tempMin)
  }
  
  var humidity: String {
    return String(format: "%.1f", item.mainWeather.humidity)
  }
  
  
  init(item: CurrentWeather) {
    self.item = item
  }
}
