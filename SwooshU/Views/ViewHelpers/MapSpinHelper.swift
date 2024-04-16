//
//  MapSpinHelper.swift
//  SwooshU
//
//  Created by Oscar Epp on 4/13/24.
//

import Foundation
import MapKit

class MapSpinHelper {
    var timer: Timer?
    weak var mapView: MKMapView?

    
    init(mapView: MKMapView) {
        self.mapView = mapView
    }

    func startRotatingCamera(distance: Double) {
        guard timer == nil else { return }

        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            guard let strongSelf = self, let mapView = strongSelf.mapView else { return }

            let currentHeading = mapView.camera.heading
            let newHeading = (currentHeading + 0.5).truncatingRemainder(dividingBy: 360)
            let newCamera = MKMapCamera(lookingAtCenter: mapView.camera.centerCoordinate, fromDistance: distance, pitch: mapView.camera.pitch, heading: newHeading)
            mapView.setCamera(newCamera, animated: false)
        }
    }

    func stopRotatingCamera() {
        timer?.invalidate()
        timer = nil
    }
}
