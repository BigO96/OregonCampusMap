//
//  LilisHall.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/9/24.
//

import SwiftUI
import MapKit

struct LilisHallDetailView: View {
    var body: some View {
        ScrollView {
            
            /// MapView
            MapViewComponent(coordinate: CLLocationCoordinate2D(latitude: 44.046030, longitude: -123.077640), distance: 300, pitch: 80, heading: -60)
                .frame(width: 350, height: 500)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding()

            // Adding text or additional content below
            VStack(alignment: .leading) {
                Text("Lilis Hall")
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
    LilisHallDetailView()
}
