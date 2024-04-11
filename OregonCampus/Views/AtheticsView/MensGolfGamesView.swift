//
//  MensGolfGamesView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/10/24.
//

import SwiftUI

struct MensGolfGamesView: View {
    
    @Environment(ModelDataMensGolf23.self) var modelDataMensGolf23
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(modelDataMensGolf23.mensGolf23) { game in
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
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemBackground)))
                    .shadow(radius: 1)
                    .padding(.horizontal, 10)
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
    MensGolfGamesView()
        .environment(ModelDataMensGolf23())

}
