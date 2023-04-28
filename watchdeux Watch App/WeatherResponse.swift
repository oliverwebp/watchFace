//
//  WeatherResponse.swift
//  watchdeux Watch App
//
//  Created by Oliver Nguyen on 4/27/23.
//

import Foundation

struct WeatherResponse: Codable {
    var forecast: [WeatherModel]
}
