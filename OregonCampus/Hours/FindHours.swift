//
//  LawrenceHours.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/15/24.
//

import SwiftUI

struct FindHours: View {
    // The place name parameter is now an optional string.
    // If nil, the view will display hours for all places.
    let placeName: String?
    
    // Load places data
    var places: Place = load("Hours.json")
    
    var body: some View {
        List {
            if let placeName = placeName {
                switch placeName {
                case "Library":
                    itemRow(systemIcon: "building.columns", title: "Library", hours: places.Library)
                case "Coffee":
                    itemRow(systemIcon: "cup.and.saucer", title: "Coffee", hours: places.Coffee)
                case "Design Printing":
                    itemRow(systemIcon: "printer", title: "Design Printing", hours: places.DesignPrinting)
                default:
                    Text("Unknown place")
                }
            } else {
                itemRow(systemIcon: "building.columns", title: "Library", hours: places.Library)
                itemRow(systemIcon: "cup.and.saucer", title: "Coffee", hours: places.Coffee)
                itemRow(systemIcon: "printer", title: "Design Printing", hours: places.DesignPrinting)
            }
        }
    }
    
    @ViewBuilder
    private func itemRow(systemIcon: String, title: String, hours: [(open: Int, close: Int)]) -> some View {
        let todayHours = hoursForToday(hours: hours)
        HStack {
            Image(systemName: systemIcon)
                .font(.system(size: 25))
            Text(title)
                .font(.system(size: 15))
            
            Spacer()
            
            Text(isOpen(hours: todayHours) ? "Open" : "Closed")
                .font(.system(size: 15))
                .foregroundColor(isOpen(hours: todayHours) ? .green : .red)
        }
    }
    
    private func isOpen(hours: (open: Int, close: Int)) -> Bool {
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        
        // Handling special case for closed all day
        if hours.open == hours.close && hours.open == 0 {
            return false
        }
        
        return hour >= hours.open && hour < hours.close
    }
    
    private func hoursForToday(hours: [(open: Int, close: Int)]) -> (open: Int, close: Int) {
        let now = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: now) - 1 // Adjusting to match your array indexes (0-based)
        
        return hours[weekday]
    }
}


extension FindHours {
    init(_ placeName: String? = nil) {
        self.placeName = placeName
    }
}

func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
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

#Preview {
    FindHours()
}
