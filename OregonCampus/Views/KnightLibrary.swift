//
//  KnightLibrary.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/13/24.
//


import SwiftUI
import MapKit

struct KnightLibraryDetailView: View {
    var body: some View {
        ScrollView {
            
            /// MapView
            MapViewComponent(coordinate: CLLocationCoordinate2D(latitude: 44.043230, longitude: -123.077705), distance: 300, pitch: 80, heading: 120)
                .frame(width: 350, height: 500)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding()

            VStack(alignment: .leading) {
                Text("Knight Library")
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
    KnightLibraryDetailView()
}
