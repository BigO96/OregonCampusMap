//
//  getCal.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/25/24.
//

import Foundation

class EventViewModel: ObservableObject {
    @Published var events: [SportsEvent] = []
    private var teamName: String
    private let teamURLs: [String: String] = [
        "Football": "https://admin.goducks.com/calendar.ashx/calendar.ics?sport_id=3&schedule_id=2466",
        "Baseball": "https://admin.goducks.com/calendar.ashx/calendar.ics?sport_id=1&schedule_id=2464",
        "Mens Basketball": "https://admin.goducks.com/calendar.ashx/calendar.ics?sport_id=6&schedule_id=2461",
        "Mens Golf": "https://admin.goducks.com/calendar.ashx/calendar.ics?sport_id=5&schedule_id=2459",
        "Mens Tennis": "https://admin.goducks.com/calendar.ashx/calendar.ics?sport_id=8&schedule_id=2453",

        "Acrobatics & Tumbling": "https://admin.goducks.com/calendar.ashx/calendar.ics?sport_id=24&schedule_id=2465",
        "Womens Basketball": "https://admin.goducks.com/calendar.ashx/calendar.ics?sport_id=12&schedule_id=2457",
        "Beach Volleyball": "https://admin.goducks.com/calendar.ashx/calendar.ics?sport_id=13&schedule_id=2468",
        "Womens Golf": "https://admin.goducks.com/calendar.ashx/calendar.ics?sport_id=15&schedule_id=2458",
        "Lacrosse": "https://admin.goducks.com/calendar.ashx/calendar.ics?sport_id=17&schedule_id=2469",
        "Soccer": "https://admin.goducks.com/calendar.ashx/calendar.ics?sport_id=18&schedule_id=2470",
        "Softball": "https://admin.goducks.com/calendar.ashx/calendar.ics?sport_id=10&schedule_id=2460",
        "Womens Tennis": "https://admin.goducks.com/calendar.ashx/calendar.ics?sport_id=19&schedule_id=2456",
        "Volleyball": "https://admin.goducks.com/calendar.ashx/calendar.ics?sport_id=21&schedule_id=2455",


        "Track and Field": "https://admin.goducks.com/calendar.ashx/calendar.ics?sport_id=11&schedule_id=2467",
        "Cross Country": "https://admin.goducks.com/calendar.ashx/calendar.ics?sport_id=2&schedule_id=2454",
        "All": "https://admin.goducks.com/calendar.ashx/calendar.ics?sport_id=11&schedule_id=2467"
    ]
    
    init(teamName: String) {
        self.teamName = teamName
        guard let urlString = teamURLs[teamName] else {
            print("URL not found for team: \(teamName)")
            return
        }
        loadEvents(from: urlString)
    }
    
    func loadEvents(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Unexpected status code: \((response as? HTTPURLResponse)?.statusCode ?? 999)")
                return
            }
            if let data = data {
                DispatchQueue.main.async {
                    self.events = self.parseICalendarData(String(data: data, encoding: .utf8) ?? "")
                    self.events.sort(by: { $0.start < $1.start })
                }
            }
        }
        task.resume()
    }
    
    private func parseICalendarData(_ data: String) -> [SportsEvent] {
        var events = [SportsEvent]()
        var currentEvent: [String: String] = [:]
        
        data.components(separatedBy: "\n").forEach { line in
            switch line {
            case let line where line.starts(with: "BEGIN:VEVENT"):
                currentEvent.removeAll()
            case let line where line.starts(with: "END:VEVENT"):
                if let event = createSportsEvent(from: currentEvent) {
                    events.append(event)
                }
            default:
                let components = line.components(separatedBy: ":")
                if components.count > 1 {
                    let key = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
                    let value = components.dropFirst().joined(separator: ":").trimmingCharacters(in: .whitespacesAndNewlines)
                    currentEvent[key] = value
                }
            }
        }
        return events
    }

    private func createSportsEvent(from dictionary: [String: String]) -> SportsEvent? {
        guard let uid = dictionary["UID"],
              var summary = dictionary["SUMMARY"],
              let description = dictionary["DESCRIPTION"],
              let location = dictionary["LOCATION"] else {
            return nil
        }
        /// Gets rid of unnecessary text
        let replacements = [
            "Oregon, University of ": "", "Football  ": "", "Baseball  ": "",
            "Basketball  ": "", "Tennis  ": "", "Track and Field  ": "",
            "Cross Country  ": "", "Golf  ": "", "Acrobatics & Tumbling  ": "",
            "Beach Volleyball  ": "", "Lacrosse  ": "", "Soccer  ": "",
            "Volleyball  ": "", "Softball  ": "", "Men's ": "", "Women's ": ""
        ]
        replacements.forEach { key, value in
            summary = summary.replacingOccurrences(of: key, with: value)
        }
        summary = summary.components(separatedBy: "-").first?.trimmingCharacters(in: .whitespaces) ?? ""
        summary = location.contains("Eugene") ? "V.S. \(summary)" : "@ \(summary)"
        
        /// Finds Win
        var isWin = ""

        /// Refactor summary and determine win status
        ["[W] ", "[N] ", "[L] "].forEach {
            if summary.contains($0) {
                if $0 == "[W] " {
                    isWin = "W"
                } else if $0 == "[L] " {
                    isWin = "L"
                } else {
                    isWin = "N/A"
                }
                            
            }
        }
    
        ["[W] ", "[N] ", "[L] "].forEach {
            if summary.contains($0) {
                summary = summary.replacingOccurrences(of: $0, with: "")/*.trimmingCharacters(in: .whitespaces) + " \($0.trimmingCharacters(in: .whitespaces))"*/
            }
        }
            
        let dtStartKey = dictionary.keys.contains("DTSTART;VALUE=DATE") ? "DTSTART;VALUE=DATE" : "DTSTART"
        let dtEndKey = dictionary.keys.contains("DTEND;VALUE=DATE") ? "DTEND;VALUE=DATE" : "DTEND"

        guard let dtStart = dictionary[dtStartKey], let dtEnd = dictionary[dtEndKey] else {
            return nil
        }

        let startDate: Date?
        let endDate: Date?

        if dtStartKey.contains(";VALUE=DATE") {
            startDate = FunkyDateFormatter.icalDateFormatter.date(from: dtStart)
        } else {
            startDate = DateFormatter.icalDateFormatter.date(from: dtStart)
        }

        if dtEndKey.contains(";VALUE=DATE") {
            endDate = FunkyDateFormatter.icalDateFormatter.date(from: dtEnd)
        } else {
            endDate = DateFormatter.icalDateFormatter.date(from: dtEnd)
        }

        guard let start = startDate, let end = endDate else {
            return nil
        }

        return SportsEvent(id: uid, summary: summary, start: start, end: end, description: description, location: location, isWin: isWin)
    }
}

extension DateFormatter {
    static let icalDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd'T'HHmmss'Z'"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}

struct FunkyDateFormatter {
    static let icalDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}

struct SportsEvent: Identifiable {
    var id: String
    var summary: String
    var start: Date
    var end: Date
    var description: String
    var location: String
    var isWin: String
}
