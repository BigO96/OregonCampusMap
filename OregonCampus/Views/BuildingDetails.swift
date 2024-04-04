//
//  BuildingDetails.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/17/24.
//

import SwiftUI
import UIKit
import MapKit

struct BuildingDetail: View {
    @Environment(ModelData.self) var modelData
    @Environment(\.colorScheme) var colorScheme
    @State private var showingMap = false
    
    var building: Building
    
    var landmarkIndex: Int {
        modelData.buildings.firstIndex(where: { $0.id == building.id})!
    }
    
    
    var body: some View {
        @Bindable var modelData = modelData
        
        GeometryReader { geometry in
            ScrollView {
                /// Title & Button
                HStack {
                    Text(building.name)
                        .font(.title)
                        .padding(.leading)
                    Spacer()
                    
                    DirectionsButton(destinationCoordinate: building.locationCoordinate, destinationName: building.name)
                }
                .padding([.top, .trailing])
                Divider()
                    .padding()
                

                /// Map View
                MapViewComponent(
                    coordinate: building.locationCoordinate,
                    distance: building.distance,
                    pitch: CGFloat(building.pitch),
                    heading: building.heading
                )
                .frame(width: geometry.size.width - 40, height: 500)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding()
                
                /// About
                VStack{
                    Text(building.description)
                        .padding()
                        .background(colorScheme == .dark ? Color(.secondarySystemBackground) : Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                }
                .frame(width: geometry.size.width - 40)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding(.bottom)
                
                /// Inside Map
                Button(action: {
                    self.showingMap = true
                }) {
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(building.imageNames, id: \.self) { imageName in
                                    Image(imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding()
                        .background(colorScheme == .dark ? Color(.secondarySystemBackground) : Color.white)
                        .frame(width: geometry.size.width - 40, height: 225)
                        .mask(Rectangle().cornerRadius(25))
                    }
                }
                
                /// Open Hours
                FindHours(building.hoursComponentKeys)
                    .scaledToFit()
                    .cornerRadius(25)
            }
            .background(colorScheme == .dark ? Color.black: Color(.systemGray6))
            .sheet(isPresented: $showingMap) {
                NavigationView {
                    BuildingMapAlbumView(imageNames: building.imageNames)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Close") {
                                showingMap = false
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let modelData = ModelData()
    return BuildingDetail(building: modelData.buildings[0])
        .environment(modelData)
}
