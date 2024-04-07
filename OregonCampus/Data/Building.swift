//
//  Building.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/17/24.
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
