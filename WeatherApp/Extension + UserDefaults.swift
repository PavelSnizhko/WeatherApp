//
//  Extension + UserDefaults.swift
//  WeatherApp
//
//  Created by Павел Снижко on 18.03.2021.
//

import Foundation

extension UserDefaults {
    @objc var cities: Float {
        get {
            return float(forKey: "cities")
        }
        set {
            set(newValue, forKey: "cities")
        }
    }
}
