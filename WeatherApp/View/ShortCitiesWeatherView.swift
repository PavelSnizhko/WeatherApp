//
//  ShortCitiesWeatherView.swift
//  WeatherApp
//
//  Created by Павел Снижко on 18.03.2021.
//
import SwiftUI
import Combine

struct ShortCitiesWeatherView: View {
    @ObservedObject var viewModel: ShortCitiesWeatherViewModel
    
    init(viewModel: ShortCitiesWeatherViewModel = ShortCitiesWeatherViewModel(weatherFetcher: WeatherFetcher())) {
      self.viewModel = viewModel
    }

    @State private var showDialog = false


        var body: some View {
            NavigationView {
                List(viewModel.dataSource) { currentWeather in
                    NavigationLink(destination: DetailWeatherView(viewModel: DetailWeatherViewModel(currentWeather: currentWeather, city: viewModel.cityStorage.getCity(id: currentWeather.cityId)))) {
                        ShortCurrentWeatherRow(currentWeather: currentWeather)
                        }
                    }
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button("Add a new city") {
                                showDialog = true
                            }
                        }
                    }
            }.alert(isPresented: $showDialog,
                     TextAlert(title: "Please enter your city",
                                   message: "Enter your city",
                                   keyboardType: .default) { result in
                       if let text = result {
                        viewModel.city = text
                            showDialog = false
                       } else {
                            showDialog = false
                       }
                     }).alert(isPresented: $viewModel.errorMessage.0) {
                        Alert(title: Text(viewModel.errorMessage.1))
                    }
        }
}


struct ShortCurrentWeatherRow: View {
    var currentWeather: CurrentWeather

    var body: some View {
        HStack{
            Text("\(currentWeather.cityName)")
            Text("\(currentWeather.mainWeather.temp)")
        }
    
    }
}
