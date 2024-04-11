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
    @State private var showingAlbum = false
    
    var building: Building
    
    var landmarkIndex: Int {
        modelData.buildings.firstIndex(where: { $0.id == building.id})!
    }
    
    let typeDescriptions: [String: String] = [
        "building.columns.fill": "Public",
        "football": "Football",
        "volleyball": "Volleyball",
        "basketball": "Basketball",
        "baseball": "Baseball",
        "soccerball": "Soccer",
        "sportscourt": "Sports",
        "cup.and.saucer.fill": "Café",
        "books.vertical.fill": "Library",
        "studentdesk": "Class",
        "fork.knife": "Dining",
        "bed.double.fill": "Housing",
        "sports": "Sports",
        "bird.fill": "Duck Store",
        "cart.fill": "Shopping",
        "printer": "Printing",
        "tutoring": "Tutoring",
        "figure.run": "Track",
        "figure.basketball": "Basketball",
        "figure.climbing": "Climbing",
        "figure.pool.swim": "Pool",
        "figure.pickleball": "Pickleball",
        "dumbbell.fill": "Weights",
        "function": "Math Help",
        "hand.raised.fingers.spread.fill" : "Tutoring"
    ]
    
    @State private var isTextExpanded: Bool = false
    private let characterLimit: Int = 100
    
    var body: some View {
        @Bindable var modelData = modelData

        
            ScrollView {
                /// Map View
                
                MapViewComponent(
                    coordinate: building.locationCoordinate,
                    distance: building.distance,
                    pitch: CGFloat(building.pitch),
                    heading: building.heading, isSpinningEnabled: true
                )
                .frame(height: 500)
                
                /// Title & Button
                HStack {
                    Text(building.name)
                        .font(.title)
                        .padding(.leading)
                    
                    Spacer()

                    
                    DisplayHours(hoursComponentKeys: building.hoursComponentKeys)

                    //            DirectionsButton(destinationCoordinate: building.locationCoordinate, destinationName: building.name)
                }
                .padding([.top, .trailing])
                
                Divider()
                
                /// Building Services
        
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(building.type, id: \.self) { type in
                            VStack {
                                Image(systemName: type)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .padding()
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(8)
                                    .foregroundColor(Color.blue)
                                
                                Text(typeDescriptions[type] ?? "Unknown")
                                    .font(.caption)
                                    .foregroundColor(Color.secondary)
                            }
                            .padding(.vertical, 4)
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                }
                
                /// About
                VStack(alignment: .leading, spacing: 5) {
                    Text(building.description)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(isTextExpanded ? nil : 3)
                        .animation(.easeInOut, value: isTextExpanded)
                        .transition(.slide)

                    if building.description.count > characterLimit && !isTextExpanded {
                        Text("Read More")
                            .foregroundColor(.blue)
                            .bold()
                            .onTapGesture {
                                withAnimation {
                                    isTextExpanded = true
                                }
                            }
                    }
                }
                .padding()
                
                Divider()

                /// Inside Map
                Button(action: {
                    self.showingAlbum = true
                }) {
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(building.imageNames, id: \.self) { imageName in
                                    Image(imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(10)
                                        .frame(height: 200)
                                }
                            }
                        }
                        .padding()
//                        .background(colorScheme == .dark ? Color(.secondarySystemBackground) : Color.white)
                        .mask(Rectangle().cornerRadius(25))
                    }
                }
                /// Open Hours
                FindHours(building.hoursComponentKeys)
                    .scaledToFit()
            }
            .ignoresSafeArea()
            .background(colorScheme == .dark ? Color.black: Color(.systemGray6))
            .sheet(isPresented: $showingAlbum) {
                NavigationView {
                    BuildingMapAlbumView(imageNames: building.imageNames)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Close") {
                                    showingAlbum = false
                                }
                            }
                        }
                }
                .cornerRadius(10)
            }
        }
    }


#Preview {
    let modelData = ModelData()
    return BuildingDetail(building: modelData.buildings[3])
        .environment(modelData)
}
