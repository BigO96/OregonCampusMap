//
//  MapView.swift
//  SwooshU
//
//  Created by Oscar Epp on 4/13/24.
//

import SwiftUI
import MapKit

struct MapSatelliteView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    var distance: CLLocationDistance
    var pitch: CGFloat
    var heading: CLLocationDirection
    var isSpinningEnabled: Bool
    
    class Coordinator {
        var mapSpinHelper: MapSpinHelper?
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsCompass = false
        mapView.mapType = .satelliteFlyover
        mapView.isUserInteractionEnabled = false

        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        mapView.setRegion(region, animated: true)
        
        let camera = MKMapCamera(lookingAtCenter: coordinate, fromDistance: distance, pitch: pitch, heading: heading)
        mapView.setCamera(camera, animated: true)

        context.coordinator.mapSpinHelper = MapSpinHelper(mapView: mapView)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let camera = MKMapCamera(lookingAtCenter: coordinate, fromDistance: distance, pitch: pitch, heading: heading)
        uiView.setCamera(camera, animated: true)
        
        if isSpinningEnabled {
            context.coordinator.mapSpinHelper?.startRotatingCamera(distance: distance)
        } else {
            context.coordinator.mapSpinHelper?.stopRotatingCamera()
        }
    }

    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: Coordinator) {
        coordinator.mapSpinHelper?.stopRotatingCamera()
    }
    
    
}

#Preview{
    MapSatelliteView(coordinate: CLLocationCoordinate2D(latitude: 44.046597, longitude: -123.076498), distance: 100, pitch: 60, heading: 120, isSpinningEnabled: false)
}
