//
//  MapView.swift
//  Socialize
//
//  Created by Micah Earl on 10/23/25.
//

import SwiftUI
import MapKit


struct MapView: View {
    let cameraPosition: MapCameraPosition = .region(.init(center: .init(latitude: 37.33, longitude: -122.009),
                                                        latitudinalMeters: 1300, longitudinalMeters: 1300))
    let locationManager = CLLocationManager()
    
    var body: some View {
        Map(initialPosition: cameraPosition) {
            // Map content
            UserAnnotation()
            Marker("Apple Visitor Center", systemImage: "laptopcomputer", coordinate: .appleVisitorCenter)
            Marker("Panama Park", systemImage: "tree.fill", coordinate: .panamaPark)
                .tint(.green)
        }
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
        }
        .mapControls {
            MapUserLocationButton()
            MapScaleView()
        }
    }
}

extension CLLocationCoordinate2D{
    static let appleHQ = CLLocationCoordinate2D(latitude: 37.3346, longitude: -122.0090)
    static let appleVisitorCenter = CLLocationCoordinate2D(latitude: 37.332753, longitude: -122.005372)
    static let panamaPark = CLLocationCoordinate2D(latitude: 37.347730, longitude: -122.018715)
}

#Preview {
    MapView()
}

