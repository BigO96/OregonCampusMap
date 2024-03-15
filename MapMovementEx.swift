//
//  SwiftUIView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/13/24.
//
import UIKit
import MapKit

class MapMovementEx: UIViewController {
    var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        setupChangeLocationButton()
    }

    func setupMapView() {
        mapView = MKMapView(frame: self.view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(mapView)
        
        
        // Set an initial location (e.g., London, UK)
        let initialLocation = CLLocationCoordinate2D(latitude: 44.046030, longitude: -123.077640)
        let initialRegion = MKCoordinateRegion(center: initialLocation, latitudinalMeters: 400, longitudinalMeters: 400)
        mapView.setRegion(initialRegion, animated: false)
    }

    func setupChangeLocationButton() {
        let changeLocationButton = UIButton(frame: CGRect(x: 20, y: self.view.frame.height - 60, width: self.view.frame.width - 40, height: 40))
        changeLocationButton.backgroundColor = .blue
        changeLocationButton.setTitle("Change Location", for: .normal)
        changeLocationButton.addTarget(self, action: #selector(changeLocationTapped(_:)), for: .touchUpInside)
        
        self.view.addSubview(changeLocationButton)
    }

    
    @objc func changeLocationTapped(_ sender: Any) {
        // New location (e.g., New York, NY)
        let newLocation = CLLocationCoordinate2D(latitude: 44.045849, longitude: -123.069174)
        
        // Determine the "flight" path by creating a new camera
        let newCamera = MKMapCamera(lookingAtCenter: newLocation, fromEyeCoordinate: mapView.camera.centerCoordinate, eyeAltitude: 5000)
        
        // Optionally adjust the pitch and heading for effect
        newCamera.pitch = 45.0
        newCamera.heading = mapView.camera.heading
        
        // Animate the camera movement for a smooth transition
        UIView.animate(withDuration: 2.0, animations: {
            self.mapView.camera = newCamera
        }) { finished in
            // Once the "flight" reaches the new location, zoom in smoothly
            let zoomedInCamera = MKMapCamera(lookingAtCenter: newLocation, fromDistance: 1000, pitch: newCamera.pitch, heading: newCamera.heading)
            UIView.animate(withDuration: 1.5) {
                self.mapView.camera = zoomedInCamera
            }
        }
    }

}

#Preview{
    MapMovementEx()
}
