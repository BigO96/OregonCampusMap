//
//  GamesDataHelper.swift
//  SwooshU
//
//  Created by Oscar Epp on 4/13/24.
//

import Foundation
import SwiftUI
import MapKit
import Combine

struct Game: Hashable, Codable, Identifiable {
    var id: Int
    var year: Int
    let event: String
    let startDate: String
    let startTime: String
    let endDate: String
    let endTime: String
    let location: String
    var result: String
}

class GameData: ObservableObject {
    @Published var FootballGames: [Game] = []
    @Published var MensBasketballGames: [Game] = []
    @Published var BaseballGames: [Game] = []
    @Published var MensGolfGames: [Game] = []
    @Published var MensTennisGames: [Game] = []
    
    @Published var WomensBasketballGames: [Game] = []
    @Published var AcrobaticsGames: [Game] = []
    @Published var BeachVolleyballGames: [Game] = []
    @Published var SoftballGames: [Game] = []
    @Published var SoccerGames: [Game] = []
    @Published var WomensGolfGames: [Game] = []
    @Published var VolleyballGames: [Game] = []
    @Published var WomensTennisGames: [Game] = []
    @Published var LacrosseGames: [Game] = []

    @Published var TrackandFieldGames: [Game] = []
    @Published var CrossCountryGames: [Game] = []
    
    init() {
        loadTeams()
    }

    private func loadTeams() {
        FootballGames = load("FootballGames.json")
        MensBasketballGames = load("MensBasketballGames.json")
        BaseballGames = load("BaseballGames.json")
        MensGolfGames = load("MensGolfGames.json")
        MensTennisGames = load("MensTennisGames.json")
        
        WomensBasketballGames = load("WomensBasketballGames.json")
        AcrobaticsGames = load("AcrobaticsGames.json")
        BeachVolleyballGames = load("BeachVolleyballGames.json")
        SoftballGames = load("SoftballGames.json")
        SoccerGames = load("SoccerGames.json")
        WomensGolfGames = load("WomensGolfGames.json")
        VolleyballGames = load("VolleyballGames.json")
        WomensTennisGames = load("WomensTennisGames.json")
        LacrosseGames = load("LacrosseGames.json")


        TrackandFieldGames = load("TrackandFieldGames.json")
        CrossCountryGames = load("CrossCountryGames.json")
    }

    private func load<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
