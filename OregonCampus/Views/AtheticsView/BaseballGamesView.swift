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
            VStack(spacing: 20) {
                ForEach(modelDataBaseball23.baseball23) { game in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(game.Event)
                            .font(.headline)
                            .foregroundColor(.primary)
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Start")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("\(game.StartDate) \(game.StartTime)")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("End")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("\(game.EndDate) \(game.EndTime)")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                            }
                        }
                        Text(game.Location)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(game.Result)
                            .font(.body)
                            .foregroundColor(resultColor(for: game.Result))
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemBackground)))
                    .shadow(radius: 2)
                    .padding(.horizontal)
                }
            }
            .padding(.top)
        }
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

#Preview {
    BaseballGamesView()
        .environment(ModelDataBaseball23())

}
