//
//  DailyView.swift
//  WeatherApp
//
//  Created by Павел Снижко on 23.03.2021.
//

import SwiftUI

struct DailyView: View {
    @ObservedObject var viewModel: DailyViewModel
    let days = Date.getDayDate()
    
    init(viewModel: DailyViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            HStack {
                ForEach(viewModel.dataSource.enumerated()) { (weather, index) in
                    makeCard(forecast: weather ,day: days[index])
                }
            }
        }.onAppear {
            viewModel.refresh()
            }
    }
    
    
    func makeCard(forecast: DailyForecast, day: String) {
        VStack {
            HStack {
                Text("Weather ⛅️ in \()")
                VStack(alignment: .leading) {
                    Text("Temperature")
                    Text(forecast.temperature.morning)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(forecast.temperature.day)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(forecast.temperature.night)
                        .font(.headline)
                        .foregroundColor(.secondary)
//                    Text(heading)
//                        .font(.title)
//                        .fontWeight(.black)
//                        .foregroundColor(.primary)
//                        .lineLimit(3)
//                    Text(author.uppercased())
//                        .font(.caption)
//                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)
         
                Spacer()
            }
            .padding()
        }
    }
    
}

