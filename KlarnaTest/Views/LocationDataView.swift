//
//  LocationDataView.swift
//  KlarnaTest
//
//  Created by Taranjeet Kaur on 23/07/23.
//

import SwiftUI

struct LocationDataView: View {
    
    var current: CurrentWeather
    
    var body: some View {
        Text(current.name)
            .font(.system(size: 35))
            .foregroundStyle(.white)
            .shadow(radius: 5)
        
        Text("\(current.main.temp.roundDouble())°")
            .font(.system(size: 60))
            .foregroundStyle(.white)
            .shadow(radius: 5)
        
        Text(current.weather.first?.description.capitalized ?? "")
            .foregroundStyle(.white)
            .shadow(radius: 5)
        
        Text("L:\(current.main.temp_min.roundDouble())° H:\(current.main.temp_max.roundDouble())°")
            .foregroundStyle(.white)
            .shadow(radius: 5)
    }
}

struct LocationDataView_Previews: PreviewProvider {
    static var previews: some View {
        Home(locationManager: LocationManager())
    }
}
