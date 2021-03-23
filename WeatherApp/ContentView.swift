//
//  ContentView.swift
//  WeatherApp
//
//  Created by Павел Снижко on 17.03.2021.
//

import SwiftUI



struct DestinationView: View {
    var body: some View {
            CityRow()
        }
    }


struct DestinationView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationView()
    }
}

struct CityRow: View {
    var body: some View {
        HStack {
            Text("Kyiv")
            Text("Temperature")
            Spacer()
            Button(
                action: {
                    print("fdsfsfs")
                },
                label: { Text("Click Me").font(.title3) }
            )
            .background(Color.blue)
            .cornerRadius(16)
        }.font(.title)
    }
}
