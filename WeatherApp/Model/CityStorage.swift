//
//  CityStorage.swift
//  WeatherApp
//
//  Created by Павел Снижко on 23.03.2021.
//

import Foundation

enum StorageError: String, Error {
    case cityAlreadyAdded = "City is already added"
}

class CitiesStorage {
    var cities: [Int: City]?
    let defaults = UserDefaults.standard
    
    
    
    init() {
        if UserDefaults.standard.object(forKey: "firstTime") == nil {
            self.cities = [703448 : City(id: 703448, coordinates: Coordinates(lon: 30.5167, lat: 50.4333), name: "Kyiv"),
                           709930 : City(id: 709930, coordinates: Coordinates(lon: 34.9833, lat: 48.45), name: "Dnipro")]
            UserDefaults.standard.setValue(true, forKey: "firstTime")
            UserDefaults.standard.set(try? PropertyListEncoder().encode(cities), forKey:"cities")
        }
        else {
            if let data = defaults.value(forKey:"cities") as? Data {
                guard let cities = try? PropertyListDecoder().decode(Dictionary<Int,City>.self, from: data) else { self.cities = [:];return}
                self.cities = cities
            }
        }
    }
    
    
    func addCity(city: City) throws -> Bool {
        guard cities?[city.id] == nil else { throw StorageError.cityAlreadyAdded }
        cities?[city.id] = city
        UserDefaults.standard.set(try? PropertyListEncoder().encode(cities), forKey:"cities")
        return true
    }
        
    func getCitiesId() -> [Int] {
        guard let cities = cities else { return [] }
        return Array<Int>(cities.keys)
    }
    
    func getCity(id: Int) -> City? {
        guard let cities = cities, let city = cities[id] else { return nil }
        return city
    }
    
}
