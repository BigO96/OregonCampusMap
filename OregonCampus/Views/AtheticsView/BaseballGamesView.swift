//
//  BaseballGamesView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/10/24.
//

import SwiftUI

struct BaseballGamesView: View {
    
    @Environment(ModelDataBaseball23.self) var modelDataBaseball23
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(modelDataBaseball23.baseball23) { game in
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(game.Event)
                                .font(.headline)
                            Group {
                                Text("Start: \(game.StartDate) \(game.StartTime) - End: \(game.EndDate) \(game.EndTime)")
                                    .font(.caption)
                                    .lineLimit(1)
                                Text(game.Location)
                                    .font(.caption)
                            }
                            .foregroundColor(.secondary)
                            
                            HStack {
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(resultColor(for: game.Result))
                                Text(game.Result)
                                    .font(.caption)
                            }
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
    BaseballGamesView()
        .environment(ModelDataBaseball23())

}
