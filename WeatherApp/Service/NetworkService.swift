//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Павел Снижко on 18.03.2021.
//

import Foundation
import Combine

enum WeatherError: Error {
  case parsing(description: String)
  case network(description: String)
}




protocol WeatherFetchable {
    func dailyWeatherForecast(forCity city: City ) -> AnyPublisher<Forecast, WeatherError>
    
    func currentWeatherForecast(forCity city: String) -> AnyPublisher<CurrentWeather, WeatherError>
    
    func currentWeatherForecasts(forCitiesId id: [Int]) -> AnyPublisher<CurrentWeatherList, WeatherError>
}

class WeatherFetcher {
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
}

// MARK: - WeatherFetchable
extension WeatherFetcher: WeatherFetchable {
    func dailyWeatherForecast(forCity city: City) -> AnyPublisher<Forecast, WeatherError> {
        return forecast(with: makeDailyForecastComponents(withCity: city))
    }
    
    func currentWeatherForecast(forCity city: String) -> AnyPublisher<CurrentWeather, WeatherError> {
        return forecast(with: makeCurrentDayForecastComponents(withCity: city))
    }
    
    func currentWeatherForecasts(forCitiesId citiesId: [Int]) -> AnyPublisher<CurrentWeatherList, WeatherError> {
        return forecast(with: makeCurrentDayForecastComponents(withCityId: citiesId))
    }
    
    
    private func forecast<T>(with components: URLComponents) -> AnyPublisher<T, WeatherError> where T: Decodable {
        guard let url = components.url else {
            let error = WeatherError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - OpenWeatherMap API
private extension WeatherFetcher {
    enum Exclude: String {
        case minutely, hourly, daily, alerts, current
    }
    
  struct OpenWeatherAPI {
    static let scheme = "https"
    static let host = "api.openweathermap.org"
    static let path = "/data/2.5"
    static let key = "eb0db420f68bf3b425633d9d4070a0b4"
  }
    
    func makeDailyForecastComponents(
        withCity city: City
    ) -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path + "/onecall"
        let excludes: [Exclude] = [.minutely, .hourly, .current, .alerts ]
        let excludesString = excludes.map( { $0.rawValue }).joined(separator: ",")
        
        components.queryItems = [
            URLQueryItem(name: "lon", value: "\(city.coordinates.lon)"),
            URLQueryItem(name: "lat", value: "\(city.coordinates.lat)"),
            URLQueryItem(name: "exclude", value: excludesString),
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "APPID", value: OpenWeatherAPI.key)
        ]
        
        return components
    }
  
  func makeCurrentDayForecastComponents(
    withCity city: String
  ) -> URLComponents {
    var components = URLComponents()
    components.scheme = OpenWeatherAPI.scheme
    components.host = OpenWeatherAPI.host
    components.path = OpenWeatherAPI.path + "/weather"
    
    components.queryItems = [
      URLQueryItem(name: "q", value: city),
      URLQueryItem(name: "mode", value: "json"),
      URLQueryItem(name: "units", value: "metric"),
      URLQueryItem(name: "APPID", value: OpenWeatherAPI.key)
    ]
    
    return components
  }
    
    func makeCurrentDayForecastComponents(withCityId citiesId: [Int]) -> URLComponents {
        let citiesIdString = citiesId.map{"\($0)"}.joined(separator: ",")
        
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path + "/group"
        
        components.queryItems = [
          URLQueryItem(name: "id", value: citiesIdString),
          URLQueryItem(name: "mode", value: "json"),
          URLQueryItem(name: "units", value: "metric"),
          URLQueryItem(name: "APPID", value: OpenWeatherAPI.key)
        ]
        
        return components
    }
}


