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
    @Binding var showBottomSheet: Bool

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
        
        NavigationView {
            VStack(spacing: 0) {
                
                RoundedRectangle(cornerRadius: 3)
                    .frame(width: 36, height: 5)
                    .foregroundColor(.gray.opacity(0.5))
                    .padding(.top, 8)
                    .padding(.bottom, 5)
                
                CustomSearchBar(text: $searchQuery, showBottomSheet: $showBottomSheet)
                    .padding(.top, 5)
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
//                .searchable(text: $searchQuery, placement: .automatic)
            }
            .background(colorScheme == .dark ? Color(.systemGray6) : Color.white)
            .ignoresSafeArea()
        }
    }
}

struct CustomSearchBar: View {
    @Binding var text: String
    @Binding var showBottomSheet: Bool
    var onCommit: () -> Void = {}
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
                
                TextField("Search", text: $text, onCommit: onCommit)
                    .foregroundColor(.primary)
                    .padding(.leading, 10)
                    .onTapGesture {
                        self.showBottomSheet = true
                    }
            }
            .frame(height: 36)
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                }
            }
        }
        .padding(.horizontal)
    }
}
//
//#Preview {
//    BuildingList()
//        .environment(ModelData())
//}
