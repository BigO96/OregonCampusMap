//
//  Games.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/10/24.
//

import Foundation
import Combine
import SwiftUI
import MapKit


struct Baseball23: Hashable, Codable, Identifiable{
    var id: Int
    let Event: String
    let StartDate: String
    let StartTime: String
    let EndDate: String
    let EndTime: String
    let Location: String
    let Result: String
}

struct MensBasketball23: Hashable, Codable, Identifiable{
    var id: Int
    let Event: String
    let StartDate: String
    let StartTime: String
    let EndDate: String
    let EndTime: String
    let Location: String
    let Result: String
}

struct MensGolf23: Hashable, Codable, Identifiable{
    var id: Int
    let Event: String
    let StartDate: String
    let StartTime: String
    let EndDate: String
    let EndTime: String
    let Location: String
}

struct Football23: Hashable, Codable, Identifiable{
    var id: Int
    let Event: String
    let StartDate: String
    let StartTime: String
    let EndDate: String
    let EndTime: String
    let Location: String
    let Result: String
}

struct MensTennis23: Hashable, Codable, Identifiable{
    var id: Int
    let Event: String
    let StartDate: String
    let StartTime: String
    let EndDate: String
    let EndTime: String
    let Location: String
}

struct TrackandField23: Hashable, Codable, Identifiable{
    var id: Int
    let Event: String
    let StartDate: String
    let StartTime: String
    let EndDate: String
    let EndTime: String
    let Location: String
}

struct CrossCountry23: Hashable, Codable, Identifiable{
    var id: Int
    let Event: String
    let StartDate: String
    let StartTime: String
    let EndDate: String
    let EndTime: String
    let Location: String
    let Result: String
}
