//
//  BuildingDetailView.swift
//  SwooshU
//
//  Created by Oscar Epp on 4/14/24.
//

import SwiftUI
import UIKit
import MapKit

struct BuildingDetail: View {
    @EnvironmentObject var BuildingDataLocal: BuildingData
    @Environment(\.colorScheme) var colorScheme
    @State private var showingAlbum = false
    
    var building: Building
    
    var landmarkIndex: Int? {
        BuildingDataLocal.Buildings.firstIndex(where: { $0.id == building.id })
    }
    
    let typeDescriptions: [String: String] = [
        "building.columns.fill": "Public",
        "football.fill": "Football",
        "volleyball.fill": "Volleyball",
        "basketball.fill": "Basketball",
        "baseball.fill": "Baseball",
        "soccerball": "Soccer",
        "sportscourt.fill": "Sports",
        "cup.and.saucer.fill": "Café",
        "books.vertical.fill": "Library",
        "studentdesk": "Class",
        "fork.knife": "Dining",
        "bed.double.fill": "Housing",
        "sports": "Sports",
        "cart.fill": "Shopping",
        "printer.fill": "Printing",
        "tutoring": "Tutoring",
        "figure.run": "Track",
        "figure.basketball": "Basketball",
        "figure.climbing": "Climbing",
        "figure.pool.swim": "Pool",
        "figure.pickleball": "Pickleball",
        "dumbbell.fill": "Weights",
        "function": "Math Help",
        "hand.raised.fingers.spread.fill" : "Tutoring",
        "figure.hiking" : "Hiking",
        "figure.fishing" : "Fishing",
        "figure.outdoor.cycle" : "Biking",
        "figure.skiing.downhill" : "Skiing",
        "bicycle" : "Biking",
        "fossil.shell.fill" : "Museum",
        "tennisball.fill" : "Tennis",
        "tree.fill" : "Park",
        "paintbrush.fill" : "Museum",
        "tshirt.fill" : "Duck Store"
    ]
    
    @State private var isTextExpanded: Bool = false
    private let characterLimit: Int = 100
    @State private var selectedTabIndex = 0
    
    var body: some View {
        ScrollView {
            MapViewComponent(
                coordinate: building.locationCoordinate,
                distance: building.distance,
                pitch: CGFloat(building.pitch),
                heading: building.heading, isSpinningEnabled: true
            )
            .frame(height: 500)
            TitleandButton
            BuildingServices
            About
            Divider()
            InsideView
            OpenHours
            Text("A")
            Text("A")
            Text("A")
            Text("A")
            Text("A")
            Text("A")
            Text("A")
            Text("A")
            Text("A")
            Text("A")

        }
    }
}

extension BuildingDetail {
    private var TitleandButton: some View {
        HStack {
            Text(building.name)
                .font(.title)
                .padding(.leading)
            
            Spacer()
            
            
            //                    DisplayHours(hoursComponentKeys: building.hoursComponentKeys)
            
            //            DirectionsButton(destinationCoordinate: building.locationCoordinate, destinationName: building.name)
        }
        .padding([.top, .trailing])
    }
}

extension BuildingDetail {
    private var BuildingServices: some View {
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
    }
}

extension BuildingDetail {
    private var About: some View {
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
    }
}

extension BuildingDetail {
    private var InsideView: some View {
        TabView {
            Group {
                Image("FentonLVL1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getRect().width - 30, height: 250)
                    .cornerRadius(15)
                    .addPinchZoom()
                    .tag(0)
                
                Image("FentonLVL2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getRect().width - 30, height: 250)
                    .cornerRadius(15)
                    .addPinchZoom()
                    .tag(1)
                
                Image("FentonLVL3")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getRect().width - 30, height: 250)
                    .cornerRadius(15)
                    .addPinchZoom()
                    .tag(2)
                
                Image("FentonLVL4")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getRect().width - 30, height: 250)
                    .cornerRadius(15)
                    .addPinchZoom()
                    .tag(3)
            }
            .padding()
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .frame(height: 250)
        .padding(.top)
        .zIndex(1000)
    }
}

extension BuildingDetail {
    private var OpenHours: some View {
        Text("Hello, World!")
        
//        FindHours(building.hoursComponentKeys)
//            .scaledToFit()
//    }
//        .ignoresSafeArea()
//        .background(colorScheme == .dark ? Color.black: Color(.systemGray6))
//        .sheet(isPresented: $showingAlbum) {
//            NavigationView {
//                BuildingMapAlbumView(imageNames: building.imageNames)
//                    .toolbar {
//                        ToolbarItem(placement: .cancellationAction) {
//                            Button("Close") {
//                                showingAlbum = false
//                            }
//                        }
//                    }
//            }
//            .cornerRadius(10)
        }
}


struct BuildingDetail_Previews: PreviewProvider {
    static var previews: some View {
        let sampleBuilding = Building(
            id: 1,
            name: "Sample Building",
            description: "This is a description of the sample building.",
            imageNames: ["image1", "image2"],
            hoursComponentKeys: ["Monday: 9-5", "Tuesday: 9-5"],
            distance: 300,
            pitch: 80,
            heading: 90.0,
            type: ["Library"],
            coordinates: Building.Coordinates(latitude: 44.042771, longitude: -123.073075)
        )
        return BuildingDetail(building: sampleBuilding)
            .environmentObject(BuildingData())
    }
}

