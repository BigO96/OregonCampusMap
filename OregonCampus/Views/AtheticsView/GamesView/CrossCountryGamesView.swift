//
//  CrossCountryGamesView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/11/24.
//

import SwiftUI

struct CrossCountryGamesView: View {
    
    @Environment(ModelDataCrossCountry23.self) var modelDataCrossCountry23
    var sortOption: String
    
    private var sortedGames: [CrossCountry23] {
        switch sortOption {
        case "Season":
            return modelDataCrossCountry23.crossCountry23.sorted { $0.startDate ?? Date.distantPast < $1.startDate ?? Date.distantPast }
        case "Upcoming":
            let now = Date()
            return modelDataCrossCountry23.crossCountry23.filter { $0.startDate ?? Date.distantFuture > now }
                .sorted { $0.startDate ?? Date.distantPast < $1.startDate ?? Date.distantPast }
        default:
            return modelDataCrossCountry23.crossCountry23
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
}

struct CrossCountryGamesView_Previews: PreviewProvider {
    static var previews: some View {
        CrossCountryGamesView(sortOption: "Season")
            .environment(ModelDataCrossCountry23())
    }
}
