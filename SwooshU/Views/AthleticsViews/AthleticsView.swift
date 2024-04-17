//
//  AthleticsView.swift
//  SwooshU
//
//  Created by Oscar Epp on 4/13/24.
//

import SwiftUI
import MapKit

struct AthleticsView: View {
    @State private var SelectedTeam = "Track & Field"
    @State private var isMensSports = true
    @EnvironmentObject var teamDataLocal: TeamData

    @State private var currentMapCoordinate = CLLocationCoordinate2D(latitude: 44.042216, longitude: -123.070818)
    @State private var currentMapDistance = 400
    @State private var currentMapPitch = 60
    @State private var currentMapHeading = 200
    
    var body: some View {
        ScrollView{
            MapSatelliteView(coordinate: currentMapCoordinate, distance: CLLocationDistance(currentMapDistance), pitch: CGFloat(currentMapPitch), heading: CLLocationDirection(currentMapHeading), isSpinningEnabled: false)
                .frame(height: 400)
            
            AthleticsCarouselView(isMensSports: $isMensSports, SelectedTeam: $SelectedTeam, currentMapCoordinate: $currentMapCoordinate, currentMapDistance: $currentMapDistance,currentMapPitch: $currentMapPitch, currentMapHeading: $currentMapHeading)
                .environmentObject(TeamData())

            Divider()
            
            AthleticsGamesView(selectedTeam: $SelectedTeam, isMensSports: $isMensSports)
                .environmentObject(GameData())

        }
        .edgesIgnoringSafeArea([.top])
    }
}

#Preview {
    AthleticsView()
        .environmentObject(TeamData())
}
