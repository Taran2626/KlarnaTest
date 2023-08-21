//
//  LocationManager.swift
//  KlarnaTest
//
//  Created by Taranjeet Kaur on 21/07/23.
//

import Foundation
import CoreLocation
import MapKit
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate, MKLocalSearchCompleterDelegate {

    private let locationManager = CLLocationManager()
       
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var location: CLLocation?
    @Published var name: String = ""
    @Published var search: String = ""
    
    @Published var searchResults = [MKLocalSearchCompletion]()
    var publisher: AnyCancellable?
    var searchCompleter = MKLocalSearchCompleter()
    
    override init() {
        super.init()
        locationManager.delegate = self
        searchCompleter.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        searchCompleter.resultTypes = [.address]
        searchCompleter.pointOfInterestFilter = .includingAll
        publisher = $search.receive(on: RunLoop.main).sink(receiveValue: { [weak self] (str) in
            self?.searchCompleter.queryFragment = str
        })
    }
    
    func reverseUpdate() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(name) { placemarks, error in
            
            guard error == nil else { return}
            
            guard let placemark = placemarks?[0] else {return}
            let coord = placemark.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
            self.location = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error loading location", error)
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
    }
}
