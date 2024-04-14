//
//  MapView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/14/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var BuildingDataLocal: BuildingData
    
    @State private var position: MapCameraPosition = .automatic
    @State private var selectedBuilding: Building?
    @State private var showBottomSheet = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Map(position: $position) {
                ForEach(BuildingDataLocal.Buildings.indices, id: \.self) { index in
                    let building = BuildingDataLocal.Buildings[index]
                    
                    Annotation(building.name, coordinate: building.locationCoordinate) {
                        Button(action: {
                            self.selectedBuilding = building
                        }) {
                            Image(systemName: building.type[0])
                                .padding(4)
                                .foregroundStyle(.white)
                                .background(colorForBuilding(building.type))
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .mapStyle(.standard(elevation: .realistic))
            .sheet(item: $selectedBuilding) { building in
                BuildingDetail(building: building)
            }
            
        }
    }
}

func colorForBuilding(_ type: [String]) -> Color {
    guard let firstType = type.first else { return .gray }
    
    switch firstType {
    case "building.columns.fill":
        return .red
    case "dumbbell.fill":
        return .red
    case "bed.double":
        return .blue
    case "books.vertical":
        return .purple
    case "studentdesk":
        return .brown
    default:
        return .green
    }
}


#Preview {
    MapView()
        .environmentObject(BuildingData())
}


