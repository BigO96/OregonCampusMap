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
    
    private func sortedMonthKeys() -> [String] {
        let sortedKeys = groupedEvents.keys.sorted {
            guard let date1 = monthYearFormatter.date(from: $0), let date2 = monthYearFormatter.date(from: $1) else {
                return false
            }
            return date1 < date2
        }
        return sortedKeys
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(sortedMonthKeys(), id: \.self) { month in
                    Section(header: Text(month).font(.headline).padding(.vertical).foregroundColor(.white)) {
                        ForEach(groupedEvents[month]!, id: \.id) { event in
                            EventRowView(event: event)
                                .padding(.vertical, 5)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
struct EventRowView: View {
    var event: SportsEvent

    var body: some View {
        HStack {
            
//            Image(systemName: "football")
//                .font(.largeTitle)
            
            VStack(alignment: .leading) {
                Text(event.summary)
                    .font(.headline)
                Text("Starts: \(event.start, formatter: itemFormatter)")
                    .font(.caption)
                    .lineLimit(1)
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.tint)
                .opacity(0.25)
                .brightness(-0.4)

        }
        .foregroundStyle(.white)
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

