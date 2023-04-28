//
//  Weather.swift
//  watchdeux Watch App
//
//  Created by Oliver Nguyen on 4/27/23.
//

import SwiftUI

struct Weather: View {
    
    @ObservedObject private var locationManager = WeatherLocationManager()
    @ObservedObject private var weatherManager = WeatherManager()
    var body: some View {
        HStack {
            Text(locationManager.cityName).lineLimit(1).font(.system(size: 14))
                .foregroundStyle(
                LinearGradient(
                    colors: [Color(red: 253/255, green: 126/255, blue: 0),Color(red: 244.0/255, green: 0.0/255, blue: 110.0/255)],
                startPoint: .leading,
                endPoint: .trailing
            ))
            Text("\(String(format: "%0.0f", weatherManager.weatherResponse.forecast.first?.temperature ?? 0.0))°")
                .font(.system(size: 14))
                .foregroundStyle(
                LinearGradient(
                    colors: [Color(red: 253/255, green: 126/255, blue: 0),Color(red: 244.0/255, green: 0.0/255, blue: 110.0/255)],
                startPoint: .leading,
                endPoint: .trailing
            ))
        }.onReceive(locationManager.$cityName, perform: {_ in
            weatherManager.getWeather(for: WeatherCoordinates(lat: locationManager.coordinate.latitude, lon: locationManager.coordinate.longitude))
        })
    }
}

struct Weather_Previews: PreviewProvider {
    static var previews: some View {
        Weather()
    }
}
