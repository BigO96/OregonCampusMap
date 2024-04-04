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

    
    
    let filterEmojis: [String: String] = [
        "cup.and.saucer": "☕️",
        "books.vertical": "📚",
        "studentdesk": "✏️",
        "fork.knife": "🍴",
        "bed.double": "🛏️",
        "sports": "🏈",
        "duckstore": "🦆",
        "shop": "🛒",
        "printer": "🖨️",
        "tutoring": "👨‍🏫"
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
                        ForEach(filterEmojis.keys.sorted(), id: \.self) { key in
                            Button(action: {
                                selectedFilter = (selectedFilter == key ? nil : key)
                                }) {
                                Text(filterEmojis[key]!)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 8)
                                    .background(selectedFilter == key ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundColor(Color.white)
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
//                .navigationTitle("Buildings")
                .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always))
                
            }
            .background(colorScheme == .dark ? Color(.systemGray6): Color.white)
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
