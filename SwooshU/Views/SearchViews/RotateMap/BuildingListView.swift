//
//  BuildingListView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 5/1/24.
//

import SwiftUI

struct BuildingListView: View {
    @EnvironmentObject var BuildingDataLocal: BuildingData
    
    @Binding var searchQuery: String
    @Binding var selectedFilter: String?
    @State private var selectedBuilding: Building?

    
    var filteredBuildings: [Building] {
        BuildingDataLocal.Buildings.filter { building in
            (searchQuery.isEmpty || building.name.localizedCaseInsensitiveContains(searchQuery)) &&
            (selectedFilter == nil || building.type.contains(selectedFilter!))
        }
    }


    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 10) {
                
                list
                
            }
            .padding(.horizontal)
        }
        .sheet(item: $selectedBuilding) { building in
            BuildingDetail(building: building)
        }
    }
}


extension BuildingListView {
    private var list: some View {
        ForEach(filteredBuildings, id: \.self) { building in
            Button(action: {
                self.selectedBuilding = building
            }) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(building.name)
                            .font(.headline)
                    }
                    Spacer()
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.tint)
                        .opacity(0.25)
                        .brightness(-0.4)
                    
                }
                .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    BuildingListView(searchQuery: .constant(""), selectedFilter: .constant(nil))
        .environmentObject(BuildingData())
    
}
