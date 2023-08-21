//
//  ContentView.swift
//  KlarnaTest
//
//  Created by Taranjeet Kaur on 21/07/23.
//

import SwiftUI
import CoreLocation

struct Home: View {
    @ObservedObject var locationManager = LocationManager()
    @StateObject var vm = WeatherViewModel()
    @State private var viewDidLoad = false
    
    var body: some View {
        
        if !vm.errorMessage.isEmpty {
            ErrorView(vm: vm, locationManager: locationManager)
        }
        else {
            NavigationView{
                ZStack {
                    GeometryReader { value in
                        Image("Sky")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: value.size.width, height: value.size.height)
                    }
                    .ignoresSafeArea()
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack {
                            
                            searchButton
                            
                            VStack(alignment: .center, spacing: 5) {
                                LocationDataView(current: vm.weather.current)
                            }
                            
                            VStack(spacing: 8) {
                                HourlyForecast(forecast: vm.weather.forecast.hourForecast)
                            }
                            
                            VStack(spacing: 8) {
                                DailyForecast(forecast: vm.weather.forecast.dayForecast)
                            }
                        }
                        .padding(.top, 25)
                        .padding([.horizontal,.bottom])
                        
                    }
                    .overlay(content: {
                        if vm.isLoading && viewDidLoad == false{
                            ZStack{
                                Color.black.opacity(1.0)
                                    .ignoresSafeArea()
                                VStack{
                                    Text("Loading...")
                                        .foregroundStyle(.white)
                                    ProgressView()
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                    })
                    .onChange(of: locationManager.location) { newValue in
                        Task { await vm.getCurrentWeather(from: locationManager.location) }
                    }
                    .task {
                        if viewDidLoad == false {
                            await vm.getCurrentWeather(from: locationManager.location)
                            viewDidLoad = true
                        }
                    }
                }
            }
        }
    }
    
    var searchButton: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink(destination: SearchView(locManager: locationManager)) {
                    Text("Search")
                    Image(systemName: "magnifyingglass.circle")
                }
                .padding(.bottom, 10)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(locationManager: LocationManager())
    }
}
