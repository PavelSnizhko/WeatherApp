//
//  View.swift
//  WeatherApp
//
//  Created by Павел Снижко on 22.03.2021.
//

import SwiftUI

extension View {
  public func alert(isPresented: Binding<Bool>, _ alert: TextAlert) -> some View {
    AlertWrapper(isPresented: isPresented, alert: alert, content: self)
  }
}
