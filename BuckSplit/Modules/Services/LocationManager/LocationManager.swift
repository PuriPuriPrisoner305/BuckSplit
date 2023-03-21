//
//  LocationManager.swift
//  BuckSplit
//
//  Created by ardy on 07/03/23.
//

import SwiftUI
import MapKit
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var mapView = MKMapView()
    @Published var region = MKCoordinateRegion(
        center:  CLLocationCoordinate2D(
          latitude: 37.789467,
          longitude:-122.416772
        ),
        span: MKCoordinateSpan(
          latitudeDelta: 0.1,
          longitudeDelta: 0.1
       )
    )
    
    @Published var searchResults = [MKLocalSearchCompletion]()
    
    // Search variable
    @Published var location: CLLocationCoordinate2D?
    @Published var name: String = ""
    @Published var search: String = ""
    var publisher: AnyCancellable?
    var searchCompleter = MKLocalSearchCompleter()
    var manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        searchCompleter.delegate = self

        self.publisher = $search.receive(on: RunLoop.main).sink(receiveValue: { [weak self] (str) in
            self?.searchCompleter.queryFragment = str
        })
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied:
            print("Please change in settings for the location permission")
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
            print("authorized")
        default:
            break
        }
        
        print("locationManagerDidChangeAuthorization")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didfail \(error)")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last?.coordinate
        update()
        mapView.setRegion(self.region, animated: true)
        mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }

}

extension LocationManager: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        
    }
    
    func getDistance(searchResult: MKLocalSearchCompletion, completionHandler: @escaping (String) -> ()) {
        let searchRequest = MKLocalSearch.Request(completion: searchResult)
        let search = MKLocalSearch(request: searchRequest)
        var placeMarkCoordinates: CLLocation = CLLocation(latitude: 0, longitude: 0)
        search.start { (response, error) in
            guard let coordinate = response?.mapItems[0].placemark.coordinate else {
                return
            }
            
            placeMarkCoordinates = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let targetloc = CLLocation(latitude: self.location?.latitude ?? 0, longitude: self.location?.longitude ?? 0)
            completionHandler("\(String(format: " Distance : %.2f ",targetloc.distance(from: placeMarkCoordinates).toKilometers())) KM")
        }
        
    }
    
    func update() {
        let latitude = location?.latitude ?? 0
        let longitude = location?.longitude ?? 0
        let span = mapView.region.span.latitudeDelta <= 0.1 ? mapView.region.span :
        MKCoordinateSpan(
            latitudeDelta: 0.1,
            longitudeDelta: 0.1
         )
        self.region = MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude)),
                                         span: span)
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { placemarks, error in

            guard let placemark = placemarks?.first else {
                let errorString = error?.localizedDescription ?? "Unexpected Error"
                print("Unable to reverse geocode the given location. Error: \(errorString)")
                return
            }

            let reversedGeoLocation = GeoLocation(with: placemark)
            self.name = reversedGeoLocation.name
        }
    }
    func reverseUpdate() {
        let geocoder = CLGeocoder()

        geocoder.geocodeAddressString(name) { placemarks, error in
            print(self.name, placemarks)
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                return
            }
            let coord = placemark.location?.coordinate ?? CLLocationCoordinate2D(latitude:
                                                                                    CLLocationDegrees(0), longitude: CLLocationDegrees(0))
            self.region = MKCoordinateRegion(center: coord, span:
                                                MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
            self.location = CLLocationCoordinate2D(latitude: placemark.location?.coordinate.latitude ?? 0, longitude: placemark.location?.coordinate.longitude ?? 0)
            
        }

    }
}

struct GeoLocation {
    let name: String
    let streetName: String
    let city: String
    let state: String
    let zipCode: String
    let country: String
    init(with placemark: CLPlacemark) {
            self.name           = placemark.name ?? ""
            self.streetName     = placemark.thoroughfare ?? ""
            self.city           = placemark.locality ?? ""
            self.state          = placemark.administrativeArea ?? ""
            self.zipCode        = placemark.postalCode ?? ""
            self.country        = placemark.country ?? ""
        }

}

extension CLLocationDistance {
    func toMiles() -> CLLocationDistance {
        return self * 0.00062137
    }

    func toKilometers() -> CLLocationDistance {
        return self / 1000
    }
}
