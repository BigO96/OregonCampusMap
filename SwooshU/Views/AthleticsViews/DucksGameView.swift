//
//  DucksGameView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/25/24.
//

import SwiftUI

struct DucksGamesView: View {
    @State private var isMensSports: Bool = true
    @State private var selectedTeam: DucksTeam
    
    let mensTeams: [DucksTeam] = ducksmensteams
    let womensTeams: [DucksTeam] = duckswomensteams
    
    init() {
        _selectedTeam = State(initialValue: ducksmensteams[0])
    }

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    
                    
                    button
                    sports
                    
                    
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
            
            TeamScheduleView(viewModel: EventViewModel(teamName: selectedTeam.name))
        }
        .background(Gradient(colors: gradientColors))

    }

    private var currentTeams: [DucksTeam] {
        isMensSports ? mensTeams : womensTeams
    }
}

let gradientColors: [Color] = [
    .gradientTop,
    .gradientBottom
]

extension DucksGamesView {
    private var button: some View {
        Button(action: {
            isMensSports.toggle()
        }) {
            VStack {
                Image(systemName: isMensSports ? "mustache.fill" : "mouth.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding()
                    .background(Color.blue.opacity(0.5))
                    .cornerRadius(8)
                    .foregroundColor(Color.white)
                
//                            Text(isMensSports ? "Men" : "Women")
//                                .font(.caption)
//                                .foregroundColor(Color.secondary)
            }
            .cornerRadius(12)
            
        }
        .padding(.leading, 10)
    }
}

extension DucksGamesView {
    private var sports: some View {
        ForEach(currentTeams, id: \.name) { team in
            Button(action: {
                selectedTeam = team
            }) {
                VStack {
                    Image(systemName: team.symbolName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding()
                        .background(selectedTeam == team ? Color.gray.opacity(0.9) : Color.blue.opacity(0.5))
                        .cornerRadius(8)
                        .foregroundColor(Color.white)
                    
                    //                                Text(team.name)
                    //                                    .font(.caption)
                    //                                    .foregroundColor(Color.secondary)
                    
                }
                .padding(.vertical, 4)
                .cornerRadius(12)
            }
        }
    }
}



#Preview {
    DucksGamesView()
}

