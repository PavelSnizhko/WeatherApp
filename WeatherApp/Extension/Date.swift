//
//  Date.swift
//  WeatherApp
//
//  Created by Павел Снижко on 23.03.2021.
//

import Foundation

extension Date {
     func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
    
  
    static func getDayDate() -> [String]{
        var listOfDate: [String] = []
        var dayComponent = DateComponents()
        for day in  1..<5 {
            dayComponent.day = day // For removing one day (yesterday): -1
            let nextDate = Calendar.current.date(byAdding: dayComponent, to: Date())
            guard let dayName = nextDate?.dayOfWeek() else { return [] }
            listOfDate.append("\(dayName)")
        }
        return listOfDate
    }
    
    
}
