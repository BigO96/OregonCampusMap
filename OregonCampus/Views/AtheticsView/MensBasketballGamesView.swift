//
//  MensBasketballGamesView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/10/24.
//

import SwiftUI

struct MensBasketballGamesView: View {
    
    @Environment(ModelDataMensBasketball23.self) var modelDataMensBasketball23
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(modelDataMensBasketball23.mensBasketball23) { game in
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(game.Location == "Eugene, OR" ? "VS" : "@") \(game.Event)")
                                .font(.headline)
                            Group {
                                Text("Start: \(game.StartDate) \(game.StartTime) - End: \(game.EndDate) \(game.EndTime)")
                                    .font(.caption)
                                    .lineLimit(1)
//                                Text(game.Location)
//                                    .font(.caption)
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
    MensBasketballGamesView()
        .environment(ModelDataMensBasketball23())

}
