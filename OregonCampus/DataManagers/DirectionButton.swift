//
//  DirectionButton.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/14/24.
//

import SwiftUI
import MapKit

struct DirectionsButton: View {
    var destinationCoordinate: CLLocationCoordinate2D
    var destinationName: String = "Destination"

    var body: some View {
        Button(action: openDirections) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                Text("Directions")
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
        }
    }
    
    private func openDirections() {
        let placemark = MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = destinationName
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
}
