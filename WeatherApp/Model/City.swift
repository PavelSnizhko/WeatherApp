//
//  City.swift
//  WeatherApp
//
//  Created by Павел Снижко on 18.03.2021.
//

import Foundation

struct City: Codable {
    let id: Int
    let coordinates: Coordinates
    let name: String

    init(id: Int, coordinates: Coordinates, name: String) {
        self.id = id
        self.coordinates = coordinates
        self.name = name
    }
    
    init(from currentWeather: CurrentWeather) {
        self.id = currentWeather.cityId
        self.coordinates = currentWeather.coord
        self.name = currentWeather.cityName
    }

}
