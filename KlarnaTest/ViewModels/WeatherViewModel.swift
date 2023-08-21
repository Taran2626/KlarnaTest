//
//  LiveWeatherViewModel.swift
//  KlarnaTest
//
//  Created by Taranjeet Kaur on 21/07/23.
//

import Foundation

protocol WeatherViewProtocol {
    var weather: Weather { get set }
    var isLoading: Bool { get }
    func getCurrentWeather(locationManager: LocationManager) async
}

class WeatherViewModel: ObservableObject, WeatherViewProtocol {
    @Published var weather: Weather = Weather.initial()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""

    let service: APIServiceProtocol

    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }

    @MainActor
    func getCurrentWeather(locationManager: LocationManager) async{

        guard let lat = locationManager.location?.coordinate.latitude.description,
              let lon = locationManager.location?.coordinate.longitude.description else { return }
        isLoading.toggle()
        defer {
            isLoading.toggle()
        }
        do {
            async let current : CurrentWeather = try await service.getJSON(urlString: getCurrentUrlString(with: lat, lon: lon))
            async let forecast : DayForecast = try await service.getJSON(urlString: getForecastUrlString(with: lat, lon: lon))
            let (currentData, forecastData) = await (try current, try forecast)
            weather = Weather(current: currentData, forecast: forecastData)
        }
        catch{
            errorMessage = error.localizedDescription
        }
    }

}

private extension WeatherViewModel {

    private func getCurrentUrlString(with lat: String, lon: String) -> String {
         "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=acb6ded70d2a2a7d7bc9430f50503177&units=metric"
    }
    
    private func getForecastUrlString(with lat: String, lon: String) -> String {
         "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=acb6ded70d2a2a7d7bc9430f50503177&units=metric"
    }

}

