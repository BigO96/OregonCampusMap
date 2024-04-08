//
//  BuildingList.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/18/24.
//

import SwiftUI

struct BuildingList: View {
    @Environment(ModelData.self) var modelData
    @State private var searchQuery = ""
    @State private var selectedFilter: String? = nil
    @Environment(\.colorScheme) var colorScheme
    
    let filterIcons: [String: String] = [
        "cup.and.saucer.fill": "cup.and.saucer.fill",
        "books.vertical.fill": "books.vertical.fill",
        "studentdesk": "studentdesk",
        "fork.knife": "fork.knife",
        "bed.double.fill": "bed.double.fill",
        "sportscourt": "sportscourt.fill",
        "bird.fill": "tshirt.fill",
        "cart.fill": "cart.fill",
        "printer": "printer.fill",
        "function": "sum",
        "hand.raised.fingers.spread.fill": "hand.raised.fingers.spread.fill"
    ]

    var filteredBuildings: [Building] {
        modelData.buildings.filter { building in
            (searchQuery.isEmpty || building.name.localizedCaseInsensitiveContains(searchQuery)) &&
            (selectedFilter == nil || building.type.contains(selectedFilter!))
        }
    }

    var body: some View {
        NavigationSplitView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(filterIcons.keys.sorted(), id: \.self) { key in
                            Button(action: {
                                selectedFilter = (selectedFilter == key ? nil : key)
                            }) {
                                Image(systemName: filterIcons[key] ?? "")
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 8)
                                    .background(selectedFilter == key ? Color.gray : Color.gray.opacity(0.2))
                                    .font(.headline)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding()
                }

                List(filteredBuildings) { building in
                    NavigationLink {
                        BuildingDetail(building: building)
                    } label: {
                        BuildingRow(building: building)
                    }
                }
                .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always))
            }
            .background(colorScheme == .dark ? Color(.systemGray6) : Color.white)
        }
        detail: {
            Text("Select a Building")
        }
    }
}

#Preview {
    BuildingList()
        .environment(ModelData())
}
