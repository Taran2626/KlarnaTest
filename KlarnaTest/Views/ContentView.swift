//
//  ContentView.swift
//  KlarnaTest
//
//  Created by Taranjeet Kaur on 23/07/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
            Home(locationManager: locationManager)
        case .restricted, .denied:  // Location services currently unavailable.
            Text("Current location data was restricted or denied.")
        case .notDetermined:        // Authorization not determined yet.
            Text("Finding your location...")
            ProgressView()
        default:
            ProgressView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
