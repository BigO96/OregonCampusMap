//
//  FindHours.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/23/24.
//
//

import SwiftUI

extension PlaceHours {
    func hoursForDay(_ day: Int) -> OpenClose {
        switch day {
        case 1: return Sunday
        case 2: return Monday
        case 3: return Tuesday
        case 4: return Wednesday
        case 5: return Thursday
        case 6: return Friday
        case 7: return Saturday
        default: return OpenClose(open: 0, close: 0)
        }
    }
}

struct PlaceHours: Codable {
    let Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday: OpenClose
}

struct OpenClose: Codable {
    let open, close: Int
}

struct Place: Codable {
    let LawrenceLibrary, LawrenceCoffee, LawrencePrinting, LillisCoffee, Lillis, KnightLibrary, KnightCoffee, KnightDREAM, UniversityHall, DesignServiceDesk, StatisticsHelpDesk, KnightTutoring, MOHRCareerServices, LillisTutoring, McKenzieHall: PlaceHours
}

struct FindHours: View {

    let placeNames: [String]
    var places: Place = load("Hours.json")
    
    var body: some View {
        List {
            ForEach(placeNames, id: \.self) { placeName in
                switch placeName {
                case "LawrenceLibrary":
                    itemRow(systemIcon: "books.vertical", title: "Library", hours: places.LawrenceLibrary)
                case "LawrenceCoffee":
                    itemRow(systemIcon: "cup.and.saucer", title: "Coffee", hours: places.LawrenceCoffee)
                case "LawrencePrinting":
                    itemRow(systemIcon: "printer", title: "Design Printing", hours: places.LawrencePrinting)
                case "Lillis":
                    itemRow(systemIcon: "building", title: "Lilis", hours: places.Lillis)
                case "LillisCoffee":
                    itemRow(systemIcon: "cup.and.saucer", title: "Coffee", hours: places.LillisCoffee)
                case "KnightLibrary":
                    itemRow(systemIcon: "building.columns", title: "Knight Library", hours: places.KnightLibrary)
                case "KnightCoffee":
                    itemRow(systemIcon: "cup.and.saucer", title: "Coffee", hours: places.KnightCoffee)
                case "KnightDREAM":
                    itemRow(systemIcon: "pencil.and.ruler", title: "DREAM Lab", hours: places.KnightDREAM
                    )
                case "UniversityHall":
                    itemRow(systemIcon: "building.columns", title: "University Hall", hours: places.UniversityHall)
                case "DesignServiceDesk":
                    itemRow(systemIcon: "questionmark.circle", title: "Design Service Desk", hours: places.DesignServiceDesk)
                case "StatisticsHelpDesk":
                    itemRow(systemIcon: "questionmark.circle", title: "Statistics Help Desk", hours: places.StatisticsHelpDesk)
                case "KnightTutoring":
                    itemRow(systemIcon: "questionmark.circle", title: "Tutoring", hours: places.KnightTutoring)
                case "MOHRCareerServices":
                    itemRow(systemIcon: "questionmark.circle", title: "MOHR Career Services", hours: places.MOHRCareerServices)
                case "LillisTutoring":
                    itemRow(systemIcon: "questionmark.circle", title: "Tutoring?", hours: places.LillisTutoring)
                case "McKenzieHall":
                    itemRow(systemIcon: "building.columns", title: "McKenzie Hall?", hours: places.McKenzieHall)
                default:
                    Text("Unknown place: \(placeName)")
                }
            }
        }
        .padding(.top, -20)
        
    }
    
    @ViewBuilder
    private func itemRow(systemIcon: String, title: String, hours: PlaceHours) -> some View {
        let todayHours = hoursForToday(hours: hours)
        let closingSoon = isClosingSoon(hours: todayHours)
        HStack {
            Image(systemName: systemIcon)
                .font(.system(size: 25))
            Text(title)
                .font(.system(size: 15))
            
            Spacer()
            
            if isOpen(hours: todayHours) {
                if closingSoon {
                    Text("Closing Soon")
                        .font(.system(size: 15))
                        .foregroundColor(.orange)
                } else {
                    Text("Open")
                        .font(.system(size: 15))
                        .foregroundColor(.green)
                }
            } else {
                Text("Closed")
                    .font(.system(size: 15))
                    .foregroundColor(.red)
            }
        }
    }

    private func isClosingSoon(hours: OpenClose) -> Bool {
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
        let currentMinutesFromMidnight = hour * 60 + minute

        // Check if the current time is within one hour of closing time
        let closingTimeMinutesFromMidnight = hours.close * 60
        let minutesUntilClose = closingTimeMinutesFromMidnight - currentMinutesFromMidnight

        return minutesUntilClose > 0 && minutesUntilClose <= 60
    }


    
    private func isOpen(hours: OpenClose) -> Bool {
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        
        // Handling special case for closed all day
        if hours.open == hours.close && hours.open == 0 {
            return false
        }
        
        return hour >= hours.open && hour < hours.close
    }

    
    private func hoursForToday(hours: PlaceHours) -> OpenClose {
        let now = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: now)
        
        switch weekday {
        case 1: return hours.Sunday
        case 2: return hours.Monday
        case 3: return hours.Tuesday
        case 4: return hours.Wednesday
        case 5: return hours.Thursday
        case 6: return hours.Friday
        case 7: return hours.Saturday
        default: fatalError("Invalid day")
        }
    }
}


extension FindHours {
    init(_ placeNames: [String] = []) {
        self.placeNames = placeNames
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
    FindHours(["LawrenceLibrary"])
}
