//
//  Teams.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/9/24.
//

import Foundation
import Combine
import SwiftUI
import MapKit


struct MensTeams: Hashable, Codable, Identifiable{
    var id: Int
    let name: String
    let symbol: String
    let distance: Int
    let pitch: Int
    let heading: Int
    var coordinates: Coordinates
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}

struct WomensTeams: Hashable, Codable, Identifiable{
    var id: Int
    let name: String
    let symbol: String
    let distance: Int
    let pitch: Int
    let heading: Int
    var coordinates: Coordinates
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
