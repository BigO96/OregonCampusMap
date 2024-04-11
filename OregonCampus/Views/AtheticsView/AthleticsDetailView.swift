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
    @State private var isMensSports = true
    @State private var currentSport = "Track & Field"
    @State private var selectedSortOption = "Season"
    let sortOptions = ["Season", "Upcoming"]

    @State private var currentMapCoordinate = CLLocationCoordinate2D(latitude: 44.042216, longitude: -123.070818)
    @State private var currentMapDistance = 400
    @State private var currentMapPitch = 60
    @State private var currentMapHeading = 200

    @Environment(ModelDataMensTeams.self) var modelDataMensTeams
    @Environment(ModelDataWomensTeams.self) var modelDataWomensTeams

    var body: some View {
        ScrollView{
            VStack {
                MapViewComponent(coordinate: currentMapCoordinate, distance: CLLocationDistance(currentMapDistance), pitch: CGFloat(currentMapPitch), heading: CLLocationDirection(currentMapHeading), isSpinningEnabled: false)
                    .frame(height: 400)
                
                HStack{

                    Button(action: {
                        isMensSports.toggle()
                    }) {
                        VStack {
                            Image(systemName: isMensSports ? "mustache.fill" : "mouth.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(8)
                                .foregroundColor(Color.blue)
                            
                            Text(isMensSports ? "Men" : "Women")
                                .font(.caption)
                                .foregroundColor(Color.secondary)
                        }
                        .padding(.leading, 10)
                        .cornerRadius(12)
                    }
                    
                    
                    if isMensSports {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                
                                ForEach(modelDataMensTeams.mensTeams, id: \.self) { team in
                                    Button(action: {
                                        currentMapCoordinate = team.locationCoordinate
                                        currentMapDistance = team.distance
                                        currentMapPitch = team.pitch
                                        currentMapHeading = team.heading
                                        currentSport = team.name
                                    }) {
                                        VStack {
                                            Image(systemName: team.symbol)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                                .padding()
                                                .background(Color.blue.opacity(0.1))
                                                .cornerRadius(8)
                                                .foregroundColor(Color.blue)
                                            
                                            Text(team.name)
                                                .font(.caption)
                                                .foregroundColor(Color.secondary)
                                        }
                                        .padding(.vertical, 4)
                                        .cornerRadius(12)
                                    }
                                }
                            }
                        }
                        .padding(.trailing)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(modelDataWomensTeams.womensTeams, id: \.self) { team in
                                    Button(action: {
                                        currentMapCoordinate = team.locationCoordinate
                                        currentMapDistance = team.distance
                                        currentMapPitch = team.pitch
                                        currentMapHeading = team.heading
                                    }) {
                                        VStack {
                                            Image(systemName: team.symbol)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                                .padding()
                                                .background(Color.blue.opacity(0.1))
                                                .cornerRadius(8)
                                                .foregroundColor(Color.blue)
                                            
                                            Text(team.name)
                                                .font(.caption)
                                                .foregroundColor(Color.secondary)
                                        }
                                        .padding(.vertical, 4)
                                        .cornerRadius(12)
                                    }
                                }
                            }
                        }
                        .padding(.trailing)
                    }
                }
                .cornerRadius(20)
                
                Divider()
                
                VStack{
                    HStack{
                        Text("\(currentSport) Schedule")
                            .font(.title2)
                            .padding(.horizontal, 20)
                        Spacer()
                        
                        Text("Year")
                            .padding(.horizontal, 20)
                    }
                    
                    Picker("Sort by", selection: $selectedSortOption) {
                        ForEach(sortOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                }
                .padding(.vertical)

                Divider()
                
                if currentSport == "Baseball" {
                    BaseballGamesView(sortOption: selectedSortOption)
                        .environment(ModelDataBaseball23())
                        .padding(.bottom, 100)
                }
                if currentSport == "Basketball" {
                    if isMensSports{
                        MensBasketballGamesView(sortOption: selectedSortOption)
                            .environment(ModelDataMensBasketball23())
                            .padding(.bottom, 100)
                    }
                }
                if currentSport == "Golf" {
                    if isMensSports{
                        MensGolfGamesView(sortOption: selectedSortOption)
                            .environment(ModelDataMensGolf23())
                            .padding(.bottom, 100)
                    }
                }
                if currentSport == "Football" {
                    FootballGamesView(sortOption: selectedSortOption)
                        .environment(ModelDataFootball23())
                        .padding(.bottom, 100)
                }
                if currentSport == "Track & Field" {
                    TrackandFieldGamesView(sortOption: selectedSortOption)
                        .environment(ModelDataTrackandField23())
                        .padding(.bottom, 100)
                }
                if currentSport == "Cross Country" {
                    CrossCountryGamesView(sortOption: selectedSortOption)
                        .environment(ModelDataCrossCountry23())
                        .padding(.bottom, 100)
                }
                
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}


#Preview{
    AthleticsDetailView()
    .environment(ModelDataMensTeams())
    .environment(ModelDataWomensTeams())

}
