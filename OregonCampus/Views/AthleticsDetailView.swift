//
//  AthleticsDetailView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/8/24.
//

import SwiftUI
import MapKit

struct AthleticsDetailView: View {

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        MapViewComponent(coordinate: CLLocationCoordinate2D(latitude: 44.046597, longitude: -123.076498), distance: 100, pitch: 60, heading: 120, isSpinningEnabled: false)
        .frame(height: 500)
        
        Text("Hello, world!")
    }
}

#Preview {
    AthleticsDetailView()

}
