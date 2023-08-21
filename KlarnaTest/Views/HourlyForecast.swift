//
//  ForecastView.swift
//  KlarnaTest
//
//  Created by Taranjeet Kaur on 21/07/23.
//

import SwiftUI

struct HourlyForecast: View {
    
    var forecast: [DayForecast.ForeCast]
    
    var body: some View {
        
        CustomStackView {
            Label {
                Text("Hourly Forecast")
            } icon: {
                Image(systemName: "clock")
            }
        } contentView: {
            VStack{
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 15) {
                        ForEach(forecast) { cast in
                            VStack(spacing: 15) {
                                Text(cast.dt_time)
                                    .font(.callout.bold())
                                if let image = cast.weather.first?.iconImage {
                                    AsyncImage(url: URL(string: image)!)
                                        .frame(width: 30)
                                }
                                Text("\(Int(cast.main.temp))°")
                                    .font(.callout.bold())

                            }
                            .padding(.horizontal, 10)
                        }
                    }
                }
            }
        }
        
    }
}

struct HourlyForecast_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecast(forecast: DayForecast.initial().hourForecast)
    }
}
