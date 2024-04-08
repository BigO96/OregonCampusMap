//
//  DisplayHours.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/7/24.
//

import SwiftUI

struct DisplayHours: View {
    var hoursComponentKeys: [String]
    var places: Place = load("Hours.json")
    
    var body: some View {
        VStack {
            if let firstPlaceKey = hoursComponentKeys.first {
                let hours = fetchHours(forKey: firstPlaceKey)
                let todayHours = hoursForToday(hours: hours)
                Text("Hours:")
                Text("\(formatTime(hour: todayHours.open)) - \(formatTime(hour: todayHours.close))")
            } else {
                Text("No places found")
            }
        }
    }
    
    private func fetchHours(forKey key: String) -> PlaceHours {
        let mirror = Mirror(reflecting: places)
        for child in mirror.children {
            if child.label == key, let hours = child.value as? PlaceHours {
                return hours
            }
        }
        return PlaceHours(Sunday: OpenClose(open: 0, close: 0), Monday: OpenClose(open: 0, close: 0), Tuesday: OpenClose(open: 0, close: 0), Wednesday: OpenClose(open: 0, close: 0), Thursday: OpenClose(open: 0, close: 0), Friday: OpenClose(open: 0, close: 0), Saturday: OpenClose(open: 0, close: 0))
    }
    
    private func hoursForToday(hours: PlaceHours) -> OpenClose {
        let now = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: now)
        
        switch weekday {
        case 1: return hours.Sunday // Sunday
        case 2: return hours.Monday // Monday
        case 3: return hours.Tuesday // Tuesday
        case 4: return hours.Wednesday // Wednesday
        case 5: return hours.Thursday // Thursday
        case 6: return hours.Friday // Friday
        case 7: return hours.Saturday // Saturday
        default: fatalError("Invalid day")
        }
    }

    
    private func formatTime(hour: Int) -> String {
        guard hour != 0 else { return "Closed" } // Handling for places closed all day
        let hourFormatted = hour % 24 // Ensure hour is within a 24-hour format
        return String(format: "%02d:00", hourFormatted)
    }

}

// Use this preview to test with a list of keys
#Preview{
    DisplayHours(hoursComponentKeys: ["LawrenceLibrary"])
}
        

