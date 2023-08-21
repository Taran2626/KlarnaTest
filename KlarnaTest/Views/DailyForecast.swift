//
//  DailyForecast.swift
//  KlarnaTest
//
//  Created by Taranjeet Kaur on 26/07/23.
//

import SwiftUI

struct DailyForecast: View {
    
    var forecast: [DayForecast.ForeCast]
    
    var body: some View {
        CustomStackView {
            Label {
                Text("Daily Forecast")
            } icon: {
                Image(systemName: "calendar")
            }
            
        } contentView: {
            VStack(alignment: .leading, spacing: 10) {
                
                ForEach(forecast) {cast in
                    
                    VStack {
                        HStack(spacing: 15) {
                            Text(cast.day)
                                .font(.title3.bold())
                                .frame(width: 50,alignment: .leading)
                            if let image = cast.weather.first?.iconImage {
                                AsyncImage(url: URL(string: image)!)
                                    .frame(width: 30,height: 30, alignment: .center)
                            }
                            Text("\(Int(cast.main.temp_min))°")
                                .font(.title3.bold())
                                .foregroundStyle(.secondary)
                                .frame(width: 40)
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(.tertiary)
                                    .foregroundStyle(.white)

                                GeometryReader{val in
                                    Capsule()
                                        .fill(.linearGradient(.init(colors: [.orange,.red]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: (cast.main.temp / cast.main.temp_max)*val.size.width)
                                }
                            }
                            .frame(height: 4)

                            Text("\(Int(cast.main.temp_max))°")
                                .font(.title3.bold())
                                .frame(width: 40)
                        }
                        Divider()
                    }
                }
            }
        }
    }
}

struct DailyForecast_Previews: PreviewProvider {
    static var previews: some View {
        DailyForecast(forecast: DayForecast.initial().dayForecast)
    }
}
