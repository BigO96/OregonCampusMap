//
//  BuildingDetailView.swift
//  SwooshU
//
//  Created by Oscar Epp on 4/14/24.
//

import SwiftUI
import UIKit
import MapKit

struct IdentifiableImage: Identifiable {
    let id: String
}


struct BuildingDetail: View {
    @EnvironmentObject var BuildingDataLocal: BuildingData
    @Environment(\.colorScheme) var colorScheme
    @State private var showingAlbum = false
    @State private var selectedImage: IdentifiableImage?
    
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
            Divider()
//            OpenHours
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
        Group {
            if building.imageNames.first != "nil" {
                TabView {
                    ForEach(building.imageNames.filter { $0 != "nil" }, id: \.self) { name in
                        Button(action: {
                            self.selectedImage = IdentifiableImage(id: name)
                        }) {
                            Image(name)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getRect().width - 30, height: 250)
                                .cornerRadius(15)
                                .gesture(
                                    MagnificationGesture()
                                        .onChanged { value in
                                            if value > 1.5 {
                                                self.selectedImage = IdentifiableImage(id: name)
                                            }
                                        }
                                )
                        }
                        .sheet(item: $selectedImage) { identifiableImage in
                            FullImageView(identifiableImage: identifiableImage)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(height: 250)
                .padding(.top)
            }
        }
    }
}

private struct FullImageView: View {
    var identifiableImage: IdentifiableImage

    var body: some View {
        VStack {
            Text(identifiableImage.id)
                .font(.title)
                .padding()
                .foregroundColor(.white)

            Spacer()

            Image(identifiableImage.id)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: getRect().width - 30, height: 250)
                .cornerRadius(15)
                .shadow(radius: 10)
                .padding()

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Gradient(colors: gradientColors))
        .edgesIgnoringSafeArea(.all)
    }
}

extension BuildingDetail {
    private var OpenHours: some View {
        Text("Building Hours go here!")
        
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


#Preview {
    let buildingData = BuildingData()
    return BuildingDetail(building: buildingData.Buildings.first!)
        .environmentObject(buildingData)
    
}

