//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Павел Снижко on 18.03.2021.
//
//
//import Foundation
//import Combine
//
//class CityViewModel: ObservableObject {
//    @Published var city: String = ""
//    
//    var cities = [703448 : City(id: 703448, coordinates: Coordinates(lon: 30.5167, lat: 50.4333), name: "Kyiv"),
//                   709930 : City(id: 709930, coordinates: Coordinates(lon: 34.9833, lat: 48.45), name: "Dnipro")]
//    private var disposables = Set<AnyCancellable>()
//
//    init(
//      weatherFetcher: WeatherFetchable,
//      scheduler: DispatchQueue = DispatchQueue(label: "WeatherViewModel")
//    ) {
//      self.weatherFetcher = weatherFetcher
//      $city
//        .dropFirst(1)
//        .debounce(for: .seconds(0.5), scheduler: scheduler)
//        .sink(receiveValue: fetchWeather(forCity:))
//        .store(in: &disposables)
//    }
//    
//    
//    func fetchWeather(forCity city: String) {
//      weatherFetcher.weeklyWeatherForecast(forCity: city)
//        .map { response in
//          response.list.map(DailyWeatherRowViewModel.init)
//        }
//        .map(Array.removeDuplicates)
//        .receive(on: DispatchQueue.main)
//        .sink(
//          receiveCompletion: { [weak self] value in
//            guard let self = self else { return }
//            switch value {
//            case .failure:
//              self.dataSource = []
//            case .finished:
//              break
//            }
//          },
//          receiveValue: { [weak self] forecast in
//            guard let self = self else { return }
//            self.dataSource = forecast
//        })
//        .store(in: &disposables)
//    }
//    
//    
//    
//    func fetchWeather(forCity city: String) {
//      weatherFetcher.weeklyWeatherForecast(forCity: city)
//        .map { response in
//          response.list.map(DailyWeatherRowViewModel.init)
//        }
//        .map(Array.removeDuplicates)
//        .receive(on: DispatchQueue.main)
//        .sink(
//          receiveCompletion: { [weak self] value in
//            guard let self = self else { return }
//            switch value {
//            case .failure:
//              self.dataSource = []
//            case .finished:
//              break
//            }
//          },
//          receiveValue: { [weak self] forecast in
//            guard let self = self else { return }
//            self.dataSource = forecast
//        })
//        .store(in: &disposables)
//    }
//}
