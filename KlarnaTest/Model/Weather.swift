//
//  Weather.swift
//  KlarnaTest
//
//  Created by Taranjeet Kaur on 21/07/23.
//

import Foundation
import SwiftUI

struct Weather: Decodable {
    let current: CurrentWeather
    let forecast: DayForecast
    
    static func initial() -> Weather {
        .init(
            current: CurrentWeather.initial(),
            forecast: DayForecast.initial()
        )
    }
}

struct DayForecast: Decodable {

    var list: [ForeCast]
    
    struct ForeCast : Identifiable, Decodable {
        var id = UUID()
        let dt: Double
        let main: MainResponse
        let weather: [WeatherResponse]
        
        var day : String {
            let date = Date(timeIntervalSince1970: dt)
            return DateFormatter.dayOnly.string(from: date)
        }
        
        var dt_txt: String {
            let date = Date(timeIntervalSince1970: dt)
            return DateFormatter.dateOnly.string(from: date)
        }
        
        var dt_time: String {
            let date = Date(timeIntervalSince1970: dt)
            return DateFormatter.timeOnly.string(from: date)
        }
        
        private enum CodingKeys: String, CodingKey {
            case dt
            case main
            case weather
        }
    }
    
    var hourForecast: [ForeCast] {
        return Array(list.prefix(8))
    }
    
    var dayForecast: [ForeCast] {
        let dates = list.unique{$0.dt_txt}
        return dates
    }

    static func initial() -> DayForecast {
        .init(list: [ForeCast(dt: 0,
                              main: MainResponse(temp: 10,
                                                 temp_min: 10,
                                                 temp_max: 10),
                              weather: [WeatherResponse(main: "",
                                                        description: "",
                                                        icon: "")]
                             )])
    }
}



struct MainResponse: Decodable {
    var temp: Double
    var temp_min: Double
    var temp_max: Double
}

struct WeatherResponse: Decodable {
    let main: String
    let description: String
    let icon: String
    
    var iconImage : String {
        return "http://openweathermap.org/img/w/" + icon + ".png"
    }
}

struct CurrentWeather: Decodable {
    let weather: [WeatherResponse]
    let main: MainResponse
    let name: String
    
    static func initial() -> CurrentWeather {
        .init(
            weather: [WeatherResponse(main: "",
                                      description: "",
                                      icon: "")],
            main: MainResponse(temp: 10,
                               temp_min: 10,
                               temp_max: 10),
            name: ""
        )
    }
}
