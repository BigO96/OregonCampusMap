//
//  TeamScheduleView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/25/24.
//

import SwiftUI

struct TeamScheduleView: View {
    @ObservedObject var viewModel: EventViewModel

    init(viewModel: EventViewModel) {
        self.viewModel = viewModel
    }
    
    private var groupedEvents: [String: [SportsEvent]] {
        Dictionary(grouping: viewModel.events, by: { monthYearFormatter.string(from: $0.start) })
    }
    
    private func colorForResult(_ result: String) -> Color {
        switch result {
        case "W":
            return .green
        case "L":
            return .red
        case "D":
            return .gray
        default:
            return .black
        }
    }
    
    var body: some View {
        List {
            /// Lists months
            ForEach(sortedMonthKeys(), id: \.self) { month in
                Section(header: Text(month).font(.headline)) {
                    /// Lists games
                    ForEach(groupedEvents[month]!) { event in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(event.summary)
                                    .font(.headline)

                                Text("Starts: \(event.start, formatter: itemFormatter)")
                                    .font(.caption)
                                    .lineLimit(1)
                                    .foregroundColor(.secondary)

                            }
                            Spacer()
                            
                            Text(event.isWin)
                                .foregroundColor(colorForResult(event.isWin))
                            

                        }
                    }
                }
            }
        }
    }
    
    private func sortedMonthKeys() -> [String] {
        let sortedKeys = groupedEvents.keys.sorted {
            guard let date1 = monthYearFormatter.date(from: $0), let date2 = monthYearFormatter.date(from: $1) else {
                return false
            }
            return date1 < date2
        }
        return sortedKeys
    }
}

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

let monthYearFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM yyyy"
    return formatter
}()

struct TeamScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        TeamScheduleView(viewModel: EventViewModel(teamName: "Football"))
    }
}

