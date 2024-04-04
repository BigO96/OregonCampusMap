//
//  OregonCampusApp.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/13/24.
//

import SwiftUI

@main
struct OregonCampusApp: App {
    @State private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
    }
}

