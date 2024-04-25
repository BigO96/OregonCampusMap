//
//  TeamsStruct.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/25/24.
//

import Foundation

struct DucksTeam: Equatable{
    let name: String
    let symbolName: String
}

let ducksmensteams = [
    DucksTeam(name: "Baseball", symbolName: "figure.baseball"),
    DucksTeam(name: "Mens Basketball", symbolName: "figure.basketball"),
    DucksTeam(name: "Football", symbolName: "figure.american.football"),
    DucksTeam(name: "Mens Golf", symbolName: "figure.golf"),
    DucksTeam(name: "Mens Tennis", symbolName: "figure.tennis"),
    
    DucksTeam(name: "Track and Field", symbolName: "figure.track.and.field"),
    DucksTeam(name: "Cross Country", symbolName: "figure.run"),
    DucksTeam(name: "All", symbolName: "sportscourt.fill")

]

let duckswomensteams = [
    DucksTeam(name: "Acrobatics & Tumbling", symbolName: "figure.yoga"),
    DucksTeam(name: "Womens Basketball", symbolName: "figure.basketball"),
    DucksTeam(name: "Beach Volleyball", symbolName: "figure.volleyball"),
    DucksTeam(name: "Womens Golf", symbolName: "figure.golf"),
    DucksTeam(name: "Lacrosse", symbolName: "figure.lacrosse"),
    DucksTeam(name: "Soccer", symbolName: "figure.soccer"),
    DucksTeam(name: "Softball", symbolName: "figure.softball"),
    DucksTeam(name: "Womens Tennis", symbolName: "figure.tennis"),
    DucksTeam(name: "Volleyball", symbolName: "figure.volleyball"),

    DucksTeam(name: "Track and Field", symbolName: "figure.track.and.field"),
    DucksTeam(name: "Cross Country", symbolName: "figure.run"),
    DucksTeam(name: "All", symbolName: "sportscourt.fill")

]
