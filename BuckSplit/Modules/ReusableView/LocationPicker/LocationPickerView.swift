//
//  LocationPickerView.swift
//  BuckSplit
//
//  Created by ardy on 07/03/23.
//

import SwiftUI
import MapKit

struct LocationPickerView: View {
    @State var isShowingSearch = false
    @Binding var selectedLocation: CLLocation
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack{
            VStack {
                MapView(mapData: locationManager)
            }
            VStack {
                SearchCompleter(locVM: locationManager)
                    .padding()
                Spacer()
            }
        }
        .sheet(isPresented: $isShowingSearch) {
            SearchCompleter(locVM: locationManager)
        }
    }
}

struct MapView: UIViewRepresentable {
    @ObservedObject var mapData: LocationManager
    
    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator()
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = mapData.mapView
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
    }
}

struct LocationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPickerView(selectedLocation: .constant(CLLocation(latitude: 34.5214, longitude: -121.214124)))
    }
}
