//
//  BuildingRowView.swift
//  SwooshU
//
//  Created by Oscar Epp on 4/14/24.
//

import SwiftUI

struct BuildingRow: View {
    var building: Building
    @EnvironmentObject var BuildingDataLocal: BuildingData
    
    var body: some View {
        HStack {
            Text(building.name)
                .foregroundColor(.primary)
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 30, idealHeight: 30, maxHeight: 30, alignment: .leading)
        .padding(.vertical, 10)
    }
}


struct BuildingRow_Previews: PreviewProvider {
    static var previews: some View {
        let sampleBuilding = Building(
            id: 1,
            name: "Sample Building",
            description: "This is a description of the sample building.",
            imageNames: ["image1", "image2"],
            hoursComponentKeys: ["Monday: 9-5", "Tuesday: 9-5"],
            distance: 0.5,
            pitch: 30.0,
            heading: 90.0,
            type: ["Library"],
            coordinates: Building.Coordinates(latitude: 44.5651, longitude: -123.279)
        )
        return BuildingRow(building: sampleBuilding)
            .environmentObject(BuildingData())
    }
}
