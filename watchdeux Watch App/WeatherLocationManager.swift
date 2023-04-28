//
//  WeatherLocationManager.swift
//  watchdeux Watch App
//
//  Created by Oliver Nguyen on 4/27/23.
//

import Foundation
import CoreLocation

final class WeatherLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var cityName = "Seattle"
    @Published var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 47.6062, longitude: -122.3321)
    
    private var locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        coordinate = location.coordinate
        
        getCityForCoordinates(location: coordinate)
        
        
    }
    
    private func getCityForCoordinates(location: CLLocationCoordinate2D) {
        let url = URL(string:"https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=\(location.latitude)&longitude=\(location.longitude)&localityLanguage=en")!
        
        NetworkManager<CityModel>().fetch(for: url) { (result) in
            switch result {
            case .failure(let err):
                print(err.localizedDescription)
            case .success(let cityData):
                self.cityName = "\(cityData.city), \(cityData.countryCode)"
            }
        }
    }
}
