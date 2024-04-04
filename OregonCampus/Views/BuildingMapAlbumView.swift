//
//  BuildingMapAlbumView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/23/24.
//

import SwiftUI
import UIKit
import MapKit

struct BuildingMapAlbumView: View {
    var imageNames: [String]
    
    @State private var selectedPage = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    let imageAspectRatio: CGFloat = 1668 / 2388
                    let frameWidth = geometry.size.width * 0.8
                    let frameHeight = frameWidth / imageAspectRatio
                    BuildingMapView(imageName: imageNames[selectedPage])
                        .frame(width: frameWidth, height: frameHeight)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .transition(.opacity)
                .padding(.bottom, 30)
                
                // Navigation Buttons
                HStack {
                    Button(action: {
                        withAnimation {
                            selectedPage = max(selectedPage - 1, 0) // Ensure the index doesn't go below 0
                        }
                    }) {
                        Image(systemName: "arrow.left")
                            .padding()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            selectedPage = min(selectedPage + 1, imageNames.count - 1) // Ensure the index doesn't exceed the array bounds
                        }
                    }) {
                        Image(systemName: "arrow.right")
                            .padding()
                    }
                }
                .padding(.horizontal, 20)
                .accentColor(.primary)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .edgesIgnoringSafeArea(.all)
        }
    }
}


struct BuildingMapAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        BuildingMapAlbumView(imageNames: ["UNIVLVL1","UNIVLVL2","UNIVLVL3"])
    }
}
