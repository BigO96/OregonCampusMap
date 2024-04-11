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

extension Baseball23 {
    var startDate: Date? {
        DateFormatter.dateFormatter.date(from: StartDate)
    }
    
    var endDate: Date? {
        DateFormatter.dateFormatter.date(from: EndDate)
    }
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

extension MensBasketball23 {
    var startDate: Date? {
        DateFormatter.dateFormatter.date(from: StartDate)
    }
    
    var endDate: Date? {
        DateFormatter.dateFormatter.date(from: EndDate)
    }
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

extension MensGolf23 {
    var startDate: Date? {
        DateFormatter.dateFormatter.date(from: StartDate)
    }
    
    var endDate: Date? {
        DateFormatter.dateFormatter.date(from: EndDate)
    }
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

extension Football23 {
    var startDate: Date? {
        DateFormatter.dateFormatter.date(from: StartDate)
    }
    
    var endDate: Date? {
        DateFormatter.dateFormatter.date(from: EndDate)
    }
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

extension MensTennis23 {
    var startDate: Date? {
        DateFormatter.dateFormatter.date(from: StartDate)
    }
    
    var endDate: Date? {
        DateFormatter.dateFormatter.date(from: EndDate)
    }
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

extension TrackandField23 {
    var startDate: Date? {
        DateFormatter.dateFormatter.date(from: StartDate)
    }
    
    var endDate: Date? {
        DateFormatter.dateFormatter.date(from: EndDate)
    }
}

struct CrossCountry23: Hashable, Codable, Identifiable{
    var id: Int
    let Event: String
    let StartDate: String
    let StartTime: String
    let EndDate: String
    let EndTime: String
    let Location: String
}

extension CrossCountry23 {
    var startDate: Date? {
        DateFormatter.dateFormatter.date(from: StartDate)
    }
    
    var endDate: Date? {
        DateFormatter.dateFormatter.date(from: EndDate)
    }
}

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        return formatter
    }()
}
