//
//  BuildingRow.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/18/24.
//

import SwiftUI

struct BuildingRow: View {
    var building: Building
    
    var body: some View {

        HStack {
            Text(building.name)
            Spacer()

//            ForEach(building.type, id: \.self) { type in
//                Image(systemName: type)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(height: 20)
//                    .padding(.trailing, 8)
//            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 30, idealHeight: 30, maxHeight: 30, alignment: .leading)
        .padding(.vertical, 10)
    }
}


#Preview {
    let buildings = ModelData().buildings
    return Group {
        BuildingRow(building: buildings[0])
        BuildingRow(building: buildings[1])
    }
}
