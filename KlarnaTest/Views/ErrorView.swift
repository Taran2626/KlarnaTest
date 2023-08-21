//
//  ErrorView.swift
//  KlarnaTest
//
//  Created by Taranjeet Kaur on 21/07/23.
//

import SwiftUI

struct ErrorView: View {
    @StateObject var vm: WeatherViewModel
    var locationManager : LocationManager
    
    var body: some View {
        Text(vm.errorMessage)
        Button {
            Task {
                await vm.getCurrentWeather(from: locationManager.location)
            }
        } label: {
            Text("Try Again")
        }
    }

}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(vm: WeatherViewModel(), locationManager: LocationManager())
    }
}
