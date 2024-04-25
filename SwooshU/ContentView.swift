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
            
            AthleticsView()
                .tabItem {
                    Label("Athletics", systemImage: "sportscourt.fill")
                }


            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .environmentObject(BuildingData())
            
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .environmentObject(BuildingData())
            
            IdView()
                .tabItem {
                    Label("Id", systemImage: "person.text.rectangle")
                }
        }
    }
}

#Preview {
    ContentView()
}
 
