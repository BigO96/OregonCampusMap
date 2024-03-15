//
//  FentonHall.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/9/24.
//

import SwiftUI
import MapKit


struct FentonHall: UIViewRepresentable {
    class Coordinator {
        var timerManager: MapViewTimerManager?
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.mapType = .satelliteFlyover
        mapView.isUserInteractionEnabled = false

        let coordinate = CLLocationCoordinate2D(latitude: 44.045756, longitude: -123.076438)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 800, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        
        let camera = MKMapCamera(lookingAtCenter: coordinate, fromDistance: 800, pitch: 80, heading: 0)
        mapView.setCamera(camera, animated: true)

        context.coordinator.timerManager = MapViewTimerManager(mapView: mapView)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        context.coordinator.timerManager?.startRotatingCamera(distance: 100)
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: Coordinator) {
        coordinator.timerManager?.stopRotatingCamera()
    }
}

struct FentonHallDetailView: View {
    var body: some View {
        ScrollView {
            // Embedding the map
            FentonHall()
                .frame(height: 400) // Set a fixed height for the map view

            VStack(alignment: .leading) {
                Text("Fenton Hall")
                    .font(.title)
                    .padding()

                Text("""
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                    """)
                    .padding([.leading, .trailing, .bottom])
            }
        }
    }
}


#Preview {
    FentonHallDetailView()
}
