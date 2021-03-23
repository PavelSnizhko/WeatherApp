//
//  DetailWeatherView.swift
//  WeatherApp
//
//  Created by Павел Снижко on 23.03.2021.
//

import SwiftUI

struct DetailWeatherView: View {
    @ObservedObject var viewModel: DetailWeatherViewModel
    
    
    init(viewModel: DetailWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            List(content: content)
            makeDailyRow()
        }
    }
}

extension DetailWeatherView {
    func makeDailyRow() -> some View {
        DailyView(viewModel: DailyViewModel(city: viewModel.city, weatherFetcher: WeatherFetcher()))
    }
}


private extension DetailWeatherView {
  func content() -> some View {
        AnyView(details(for: CurrentWeatherRowViewModel(item: viewModel.currentWeather)))
    }

  func details(for viewModel: CurrentWeatherRowViewModel) -> some View {
    CurrentWeatherRow(viewModel: viewModel)
  }

  var loading: some View {
    Text("Loading \(viewModel.currentWeather.cityName)'s weather...")
      .foregroundColor(.gray)
  }
}
