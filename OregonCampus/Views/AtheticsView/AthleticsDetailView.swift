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
    @State private var currentSport = "Baseball"

    @State private var currentMapCoordinate = CLLocationCoordinate2D(latitude: 44.042216, longitude: -123.070818)
    @State private var currentMapDistance = 400
    @State private var currentMapPitch = 60
    @State private var currentMapHeading = 200

    @Environment(ModelDataMensTeams.self) var modelDataMensTeams
    @Environment(ModelDataWomensTeams.self) var modelDataWomensTeams

    var body: some View {
        VStack {
            MapViewComponent(coordinate: currentMapCoordinate, distance: CLLocationDistance(currentMapDistance), pitch: CGFloat(currentMapPitch), heading: CLLocationDirection(currentMapHeading), isSpinningEnabled: false)
                .frame(height: 400)

            Button(action: {
                isMensSports.toggle()
            }) {
                Text(isMensSports ? "Show Women's Sports" : "Show Men's Sports")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            
            if isMensSports {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(modelDataMensTeams.mensTeams, id: \.self) { team in
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
                    .padding(.horizontal)
                }
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
                    .padding(.horizontal)
                }
            }
            
            BaseballGamesView()
                .environment(ModelDataBaseball23())

            Spacer()
        }
        .ignoresSafeArea()
    }
}


#Preview{
    AthleticsDetailView()
    .environment(ModelDataMensTeams())
    .environment(ModelDataWomensTeams())

}
