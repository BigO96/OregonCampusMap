//
//  CampusMapView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/6/24.
//


import SwiftUI
import MapKit

struct CampusMapView: View {
    @Environment(ModelData.self) var modelData
    @State private var position: MapCameraPosition = .automatic
    @State private var selectedBuilding: Building?

    var body: some View {
        Map(position: $position) {
            ForEach(modelData.buildings.indices, id: \.self) { index in
                let building = modelData.buildings[index]

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

func colorForBuilding(_ type: [String]) -> Color {
    guard let firstType = type.first else { return .gray } // Fallback color if the list is unexpectedly empty
    
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
        return .green // Default color if the first item doesn't match any case
    }
}


struct CampusMapView_Previews: PreviewProvider {
    static var previews: some View {
        CampusMapView()
            .environment(ModelData())
    }
}

