//
//  MensGolfGamesView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/10/24.
//

import SwiftUI

struct MensGolfGamesView: View {
    
    @Environment(ModelDataMensGolf23.self) var modelDataMensGolf23
    var sortOption: String
    
    private var sortedGames: [MensGolf23] {
        switch sortOption {
        case "Season":
            return modelDataMensGolf23.mensGolf23.sorted { $0.startDate ?? Date.distantPast < $1.startDate ?? Date.distantPast }
        case "Upcoming":
            let now = Date()
            return modelDataMensGolf23.mensGolf23.filter { $0.startDate ?? Date.distantFuture > now }
                .sorted { $0.startDate ?? Date.distantPast < $1.startDate ?? Date.distantPast }
        default:
            return modelDataMensGolf23.mensGolf23
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(sortedGames, id: \.id) { game in
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(game.Event)")
                                .font(.headline)
                            Group {
                                Text("Start: \(game.StartDate) \(game.StartTime) - End: \(game.EndDate) \(game.EndTime)")
                                    .font(.caption)
                                    .lineLimit(1)
                                Text(game.Location)
                                    .font(.caption)
                            }
                            .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemBackground)))
                    .padding(.horizontal, 20)
                    Divider()
                }
            }
            .padding(.top, 5)
        }
    }
    
    func resultColor(for result: String) -> Color {
        if result.contains("W") {
            return .green
        } else if result.contains("L") {
            return .red
        } else if result.contains("D") {
            return .yellow
        } else {
            return .gray
        }
    }
}

#Preview {
    MensGolfGamesView(sortOption: "Upcoming")
        .environment(ModelDataMensGolf23())

}
