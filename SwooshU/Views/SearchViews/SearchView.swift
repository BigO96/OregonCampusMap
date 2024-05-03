//
//  SearchView.swift
//  SwooshU
//
//  Created by Oscar Epp on 4/14/24.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var BuildingDataLocal: BuildingData
    @State private var searchQuery: String = ""
    @State private var selectedFilter: String?
    @Environment(\.colorScheme) var colorScheme
    @State private var isSearching = false

    
    let filterIcons: [String: String] = [
        "cup.and.saucer.fill": "cup.and.saucer.fill",
        "books.vertical.fill": "books.vertical.fill",
        "studentdesk": "studentdesk",
        "fork.knife": "fork.knife",
        "bed.double.fill": "bed.double.fill",
        "sportscourt.fill": "sportscourt.fill",
        "tshirt.fill": "tshirt.fill",
        "cart.fill": "cart.fill",
        "printer.fill": "printer.fill",
        "function": "sum",
        "hand.raised.fingers.spread.fill": "hand.raised.fingers.spread.fill"
    ]

    var body: some View {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        
                        if isSearching {
                            searchField
                        } else {
                            searchButton
                        }
                        
                        filterOptions
                    
                    }
                    .padding(.horizontal)
                    
                }
                .padding(.vertical)
                
                BuildingListView(searchQuery: $searchQuery, selectedFilter: $selectedFilter)
            
            }
            .background(Gradient(colors: gradientColors))
    }
}

extension SearchView {
    private var searchField: some View {
        TextField("Search buildings", text: $searchQuery, onCommit: {
            withAnimation {
                isSearching = false
            }
        })
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .background(Color.gray.opacity(0.5))
        .cornerRadius(12)
    }

    private var searchButton: some View {
        Button(action: {
            withAnimation {
                isSearching.toggle()
            }
        }) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding()
                .background(Color.blue.opacity(0.5))
                .cornerRadius(8)
                .foregroundColor(Color.white)
        }
        .opacity(isSearching ? 0 : 1)
        .animation(.easeInOut, value: isSearching)

    }
    
    private var filterOptions: some View {
        ForEach(filterIcons.keys.sorted(), id: \.self) { key in
            Button(action: {
                selectedFilter = (selectedFilter == key ? nil : key)
            }) {
                VStack {
                    Image(systemName: filterIcons[key] ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding()
                        .background(selectedFilter == key ? Color.gray.opacity(0.9) : Color.blue.opacity(0.5))
                        .cornerRadius(8)
                        .foregroundColor(Color.white)
                }
                .padding(.vertical, 4)
                .cornerRadius(12)
            }
        }
    }
}


#Preview {
    SearchView()
        .environmentObject(BuildingData())
}
