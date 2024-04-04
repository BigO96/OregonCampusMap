//
//  ContentView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/13/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            BuildingList()
                .tabItem {
                    Label("Buildings", systemImage: "building.columns.fill")
                }
                
            Text("Second View")
                .tabItem {
                    Label("Second", systemImage: "square.fill.text.grid.1x2")
                }
            
            IdView()
                .tabItem {
                    Label("Id", systemImage: "person.text.rectangle")
                }
        }
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
 
