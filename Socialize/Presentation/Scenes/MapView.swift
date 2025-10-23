//
//  MapView.swift
//  Socialize
//
//  Created by Micah Earl on 10/23/25.
//

import SwiftUI
import MapKit
import CoreLocation
import Combine

/// A simple location manager to request "When In Use" authorization.
final class LocationAuthorization: NSObject, ObservableObject, CLLocationManagerDelegate {
    let objectWillChange = ObservableObjectPublisher()
    
    private let manager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined

    override init() {
        super.init()
        // Configure manager after super.init
        manager.delegate = self
        // Seed current status
        authorizationStatus = manager.authorizationStatus
    }

    func requestWhenInUseAuthorization() {
        // If not determined, ask for When In Use
        if authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async {
            self.authorizationStatus = manager.authorizationStatus
        }
    }
}

struct MapView: View {
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )

    @StateObject private var locationAuth = LocationAuthorization()

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map(position: $position, interactionModes: .all) {
                UserAnnotation()
            }
            .ignoresSafeArea()

            // Built-in button to center/follow the user's location
            VStack(alignment: .trailing, spacing: 8) {
                MapUserLocationButton()
                    .labelStyle(.iconOnly)
                    .clipShape(Circle())
                    .padding(12)
            }
        }
        .onAppear {
            locationAuth.requestWhenInUseAuthorization()
        }
    }
}

#Preview {
    MapView()
}

