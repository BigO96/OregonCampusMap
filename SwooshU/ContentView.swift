//
//  ContentView.swift
//  SwooshU
//
//  Created by Oscar Epp on 3/13/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DucksGamesView()
                .tabItem {
                    Label("Athletics", systemImage: "sportscourt.fill")
                }

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            
            IdView()
                .tabItem {
                    Label("Id", systemImage: "person.text.rectangle")
                }
        }
        .environmentObject(BuildingData())
    }
}

#Preview {
    ContentView()
}
 
