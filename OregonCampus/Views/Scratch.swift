//
//  Scratch.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/7/24.
//
//
//import SwiftUI
//import MapKit
//
//struct CampusMapView: View {
//    @Environment(ModelData.self) var modelData
//    @State private var position: MapCameraPosition = .automatic
//    @State private var selectedBuilding: Building? // Change to your Building type
//
//    var body: some View {
//        Map(position: $position) {
//            ForEach(modelData.buildings.indices, id: \.self) { index in
//                let building = modelData.buildings[index]
//                
//                Annotation(building.name, coordinate: building.locationCoordinate) {
//                    Button(action: {
//                        self.selectedBuilding = building
//                    }) {
//                        Image(systemName: building.type[0])
//                            .padding(4)
//                            .foregroundStyle(.white)
//                            .background(index == 10 ? Color.red : Color.brown)
//                            .cornerRadius(10)
//                    }
//                }
//            }
//        }
//        .mapStyle(.standard(elevation: .realistic))
//        .sheet(item: $selectedBuilding) { building in
//            BuildingDetail(building: building)
//        }
//    }
//}
//
//
//struct CampusMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        CampusMapView()
//            .environment(ModelData())
//    }
//}
//

