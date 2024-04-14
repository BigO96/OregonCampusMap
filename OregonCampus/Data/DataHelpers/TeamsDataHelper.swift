//
//  TeamsDataHelper.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/13/24.
//

import Foundation
import SwiftUI
import MapKit
import Combine


struct Team: Hashable, Codable, Identifiable {
    var id: Int
    let name: String
    let symbol: String
    let distance: Int
    let pitch: Int
    let heading: Int
    var coordinates: Coordinates
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
}

class TeamData: ObservableObject {
    @Published var mensTeams: [Team] = []
    @Published var womensTeams: [Team] = []

    init() {
        loadTeams()
    }

    private func loadTeams() {
        mensTeams = load("MensTeams.json")
        womensTeams = load("WomensTeams.json")
    }
    
    private func load<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}


