////
////  SportCarousell.swift
////  OregonCampus
////
////  Created by Oscar Epp on 4/10/24.
////
//
//import SwiftUI
//import MapKit
//
//struct SportsCarouselView: View {
//    let isMensSports: Bool
//    let modelDataMensTeams: ModelDataMensTeams
//    let modelDataWomensTeams: ModelDataWomensTeams
//    var currentMapCoordinate: Binding<CLLocationCoordinate2D>
//    var currentMapDistance: Binding<Int>
//    var currentMapPitch: Binding<Int>
//    var currentMapHeading: Binding<Int>
//    
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 10) {
//                if isMensSports {
//                    ForEach(modelDataMensTeams.mensTeams, id: \.self) { team in
//                        TeamButton(team: team, currentMapCoordinate: currentMapCoordinate, currentMapDistance: currentMapDistance, currentMapPitch: currentMapPitch, currentMapHeading: currentMapHeading)
//                    }
//                } else {
//                    ForEach(modelDataWomensTeams.womensTeams, id: \.self) { team in
//                        TeamButton(team: team, currentMapCoordinate: currentMapCoordinate, currentMapDistance: currentMapDistance, currentMapPitch: currentMapPitch, currentMapHeading: currentMapHeading)
//                    }
//                }
//            }
//            .padding(.horizontal)
//        }
//    }
//}
