//
//  DailyViewModel.swift
//  WeatherApp
//
//  Created by Павел Снижко on 23.03.2021.
//

import Foundation
import Combine


class DailyViewModel: ObservableObject {
    let city: City?
    @Published var dataSource: [DailyForecast] = []
    let weatherFetcher: WeatherFetchable
    
    private var disposables = Set<AnyCancellable>()

    
    init(city: City?, weatherFetcher: WeatherFetchable) {
        self.city = city
        self.weatherFetcher = weatherFetcher
    }
    
    func refresh() {
        guard let city = self.city else { return }
      weatherFetcher
        .dailyWeatherForecast(forCity: city)
//        .map(CurrentWeatherRowViewModel.init)
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] value in
          guard let self = self else { return }
          switch value {
          case .failure(let error):
            self.dataSource = []
          case .finished:
            break
          }
        }, receiveValue: { [weak self] forecast in
            guard let self = self else { return }
            self.dataSource = forecast.daily
            print(self.dataSource)
        })
        .store(in: &disposables)
    }
}
