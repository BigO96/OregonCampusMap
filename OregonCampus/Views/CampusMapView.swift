//
//  CampusMapView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/6/24.
//

import SwiftUI
import MapKit

struct CampusMapView: View{
    @Environment(ModelData.self) var modelData
    @State private var position: MapCameraPosition = .automatic
    
    var body: some View {
        
        
        Map(position: $position) {
            ForEach(modelData.buildings.indices, id: \.self) { index in
                let building = modelData.buildings[index]
                
                Annotation(building.name, coordinate: building.locationCoordinate) {
                    Image(systemName: building.type[0])
                        .padding(4)
                        .foregroundStyle(.white)
                        .background(index == 10 ? Color.red : Color.brown) // Example conditional styling for the 11th building
                        .cornerRadius(10)
                }
            }
        }
        .mapStyle(.standard(elevation: .realistic))
    }
}



struct CampusMapView_Previews: PreviewProvider {
    static var previews: some View {
        CampusMapView()
            .environment(ModelData())
    }
}




//            Annotation(modelData.buildings[10].name, coordinate: modelData.buildings[10].locationCoordinate) {
//                Image(systemName: "graduationcap")
//                    .padding(4)
//                    .foregroundStyle(.white)
//                    .background(Color.red)
//                    .cornerRadius(10)
//            }
//
//            ForEach(campusLocations, id: \.name) { location in
//                Annotation(location.name, coordinate: location.coordinate) {
//                    Image(systemName: "graduationcap")
//                        .padding(4)
//                        .foregroundStyle(.white)
//                        .background(Color.brown)
//                        .cornerRadius(10)
//                }
//            }
