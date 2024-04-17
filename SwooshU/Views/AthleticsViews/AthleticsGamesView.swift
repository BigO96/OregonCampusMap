//
//  AthleticsGamesView.swift
//  SwooshU
//
//  Created by Oscar Epp on 4/13/24.
//

import SwiftUI

struct AthleticsGamesView: View {
    @EnvironmentObject var gameDataLocal: GameData
    @Binding var selectedTeam: String
    @Binding var isMensSports: Bool

    @State private var selectedYear: Int = 2023
    @State private var selectedSortOption = "Season"
    let sortOptions = ["Season", "Upcoming"]
    let yearOptions = Array(2020...2024)

    private var selectedGames: [Game] {
        let allGames: [Game]
        switch selectedTeam {
        case "Football":
            allGames = gameDataLocal.FootballGames
        case "Basketball":
            allGames = isMensSports ? gameDataLocal.MensBasketballGames : gameDataLocal.WomensBasketballGames
        case "Baseball":
            allGames = gameDataLocal.BaseballGames
        case "Track & Field":
            allGames = gameDataLocal.TrackandFieldGames
        case "Tennis":
            allGames = gameDataLocal.TennisGames
        case "Golf":
            allGames = gameDataLocal.MensGolfGames
        case "Cross Country":
            allGames = gameDataLocal.CrossCountryGames
            
        default:
            return []
        }
        
        
        let filteredGames = allGames.filter { $0.year == selectedYear }
        
        switch selectedSortOption {
        case "Season":
            return filteredGames.sorted { $0.startDate < $1.startDate }
        case "Upcoming":
            return filteredGames.filter { $0.result.contains("TBD") }
                .sorted { $0.startDate < $1.startDate }
        default:
            return filteredGames
        }
    }
    
    var body: some View {
        
        VStack{
            HStack{
                Text("\(selectedTeam) Schedule")
                    .font(.title2)
                    .padding(.horizontal, 20)
                Spacer()
                
                Picker("Year", selection: $selectedYear) {
                    ForEach(yearOptions, id: \.self) { year in
                        Text(String(year)).tag(Int?.some(year))
                    }
                }
                .pickerStyle(DefaultPickerStyle())
                .padding(.horizontal, 20)
            }
            
            Picker("Sort by", selection: $selectedSortOption) {
                ForEach(sortOptions, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
        }
        .padding(.vertical)
        
        
        ScrollView {
            VStack(spacing: 10) {
                ForEach(selectedGames, id: \.id) { game in
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(game.location == "Eugene, Ore." ? "VS" : "@") \(game.event)")
                                .font(.headline)
                            Group {
                                Text("Start: \(game.startDate) \(game.startTime) - End: \(game.endDate) \(game.endTime)")
                                    .font(.caption)
                                    .lineLimit(1)
                            }
                            .foregroundColor(.secondary)
                            
                            HStack {
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(resultColor(for: game.result))
                                Text(game.result)
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
    AthleticsGamesView(selectedTeam: .constant("Football"), isMensSports: .constant(true))
        .environmentObject(GameData())
}
