//
//  BuildingsDataHelper.swift
//  SwooshU
//
//  Created by Oscar Epp on 4/14/24.
//

import Foundation
import SwiftUI
import CoreLocation

struct Building: Hashable, Codable, Identifiable{
    var id: Int
    var name: String
    var description: String
    var imageNames: [String]
    var hoursComponentKeys: [String]
    var distance: Double
    var pitch: Double
    var heading: Double
    var type: [String]

    var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
    
    struct Coordinates: Hashable, Codable{
        var latitude: Double
        var longitude: Double
    }
}

class BuildingData: ObservableObject {
    @Published var Buildings: [Building] = []
    
    init() {
        loadTeams()
    }
    
    private func loadTeams() {
        Buildings = load("BuildingData.json")
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
