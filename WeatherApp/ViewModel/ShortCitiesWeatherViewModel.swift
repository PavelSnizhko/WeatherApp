//
//  ShortCitiesWeatherViewModel.swift
//  WeatherApp
//
//  Created by Павел Снижко on 18.03.2021.
//

import Foundation
import Combine

class ShortCitiesWeatherViewModel: ObservableObject {
    @Published var city: String = "Kiyv"
    @Published var currentWeather = [CurrentWeather]()
    
    @Published var cities: [City] = []
    @Published var dataSource: [CurrentWeather] = []
    @Published var errorMessage: (Bool, String) = (false, "")
    
    private let weatherFetcher: WeatherFetchable
    private var disposables = Set<AnyCancellable>()
    let cityStorage = CitiesStorage()
    
    init(weatherFetcher: WeatherFetchable, scheduler: DispatchQueue = DispatchQueue(label: "WeatherViewModel")) {
        
        self.weatherFetcher = weatherFetcher
        
        refresh()
        
        $city
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink(receiveValue: fetchWeather(forCity:))
            .store(in: &disposables)
    }
    
    func fetchWeather(forCity city: String) {
        weatherFetcher.currentWeatherForecast(forCity: city)
        .receive(on: RunLoop.main)
        .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure:
                self.errorMessage = (true, "Wrong city name")
            case .finished:
              break
            }
          },
          receiveValue: { [weak self] forecast in
            guard let self = self else { return }
            guard (try? self.cityStorage.addCity(city: City(from: forecast))) != nil else {
                self.errorMessage = (true, StorageError.cityAlreadyAdded.rawValue)
                return
            }
            self.dataSource.append(forecast)
        }).store(in: &disposables)
    }
    
    func refresh() {
        let citiesId = self.cityStorage.getCitiesId()

        self.weatherFetcher.currentWeatherForecasts(forCitiesId: citiesId)
            .receive(on: RunLoop.main)
            .sink(
              receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure(let error):
                    print(error)
                    self.errorMessage = (true, "Oooops smth is wrong")
                case .finished:
                  break
                }
              },
              receiveValue: { [weak self] forecasts in
                guard let self = self else { return }
                self.dataSource = forecasts.currentWeathers
            }).store(in: &disposables)
        }
}
