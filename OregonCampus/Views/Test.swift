////
////  Test.swift
////  OregonCampus
////
////  Created by Oscar Epp on 4/4/24.
////
//
//import SwiftUI
//import UIKit
//import MapKit
//
//struct BuildingDetailTest: View {
//    @Environment(ModelData.self) var modelData
//    @Environment(\.colorScheme) var colorScheme
//    @State private var showingAlbum = false
//    @State private var isMapExpanded = false
//
//    var building: Building
//    
//    var landmarkIndex: Int {
//        modelData.buildings.firstIndex(where: { $0.id == building.id })!
//    }
//    
//    
//    var body: some View {
//        
//        /// Title & Button
//        HStack {
//            Text(building.name)
//                .font(.title)
//                .padding(.leading)
////            Spacer()
//            
////            DirectionsButton(destinationCoordinate: building.locationCoordinate, destinationName: building.name)
//        }
////        .padding([.top, .trailing])
//        
//        GeometryReader { geometry in
//            ZStack(alignment: .topLeading) {
//                if isMapExpanded {
//                    MapViewComponent(
//                        coordinate: building.locationCoordinate,
//                        distance: building.distance,
//                        pitch: CGFloat(building.pitch),
//                        heading: building.heading
//                    )
//                    .edgesIgnoringSafeArea(.all)
//                    .transition(.move(edge: .bottom))
//                    .animation(.easeInOut, value: isMapExpanded)
//                    
//                    Button(action: {
//                        withAnimation {
//                            self.isMapExpanded = false
//                        }
//                    }) {
//                        Image(systemName: "chevron.down.circle.fill")
//                            .font(.largeTitle)
//                            .foregroundColor(.white)
//                            .padding()
//                    }
//                } else {
//                    ScrollView {
//                        Button(action: {
//                            withAnimation {
//                                self.isMapExpanded = true
//                            }
//                        }) {
//                            MapViewComponent(
//                                coordinate: building.locationCoordinate,
//                                distance: building.distance,
//                                pitch: CGFloat(building.pitch),
//                                heading: building.heading
//                            )
//                            .frame(width: geometry.size.width - 40, height: 500)
//                            .clipShape(RoundedRectangle(cornerRadius: 25))
//                            .padding()
//                        }
//                        .transition(.move(edge: .top))
//                        
//                        /// About
//                        VStack {
//                            Text(building.description)
//                                .padding()
//                                .background(colorScheme == .dark ? Color(.secondarySystemBackground) : Color.white)
//                                .clipShape(RoundedRectangle(cornerRadius: 25))
//                        }
//                        .frame(width: geometry.size.width - 40)
//                        .clipShape(RoundedRectangle(cornerRadius: 25))
//                        .padding(.bottom)
//                        
//                        /// Inside Map
//                        Button(action: {
//                            self.showingAlbum = true
//                        }) {
//                            VStack {
//                                ScrollView(.horizontal, showsIndicators: false) {
//                                    HStack(spacing: 20) {
//                                        ForEach(building.imageNames, id: \.self) { imageName in
//                                            Image(imageName)
//                                                .resizable()
//                                                .scaledToFit()
//                                                .cornerRadius(10)
//                                        }
//                                    }
//                                }
//                                .padding()
//                                .background(colorScheme == .dark ? Color(.secondarySystemBackground) : Color.white)
//                                .frame(width: geometry.size.width - 40, height: 225)
//                                .mask(Rectangle().cornerRadius(25))
//                            }
//                        }
//                        
//                        /// Open Hours
//                        FindHours(building.hoursComponentKeys)
//                            .scaledToFit()
//                            .cornerRadius(25)
//                    }
//                    .background(colorScheme == .dark ? Color.black : Color(.systemGray6))
//                }
//            }
//            .sheet(isPresented: $showingAlbum) {
//                NavigationView {
//                    BuildingMapAlbumView(imageNames: building.imageNames)
//                        .toolbar {
//                            ToolbarItem(placement: .cancellationAction) {
//                                Button("Close") {
//                                    showingAlbum = false
//                                }
//                            }
//                        }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    let modelData = ModelData()
//    return BuildingDetailTest(building: modelData.buildings[0])
//        .environment(modelData)
//}
