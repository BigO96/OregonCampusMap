//
//  AthleticsDetailView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/8/24.
//

import SwiftUI
import MapKit

struct Sport {
    let name: String
    let symbol: String
    let coordinate: CLLocationCoordinate2D
    let distance: Int
    let pitch: Int
    let heading: Int
    var games: [Game]
}

struct Game {
    let opponent: String
    let date: String
    let location: String
}

struct AthleticsDetailView: View {

    @Environment(\.colorScheme) var colorScheme

    @State private var isMensSports = true
    @State private var selectedSport: Sport?

    @State private var currentMapCoordinate = CLLocationCoordinate2D(latitude: 44.042216, longitude: -123.070818)
    @State private var currentMapDistance = 400
    @State private var currentMapPitch = 60
    @State private var currentMapHeading = 200

    let mensSports: [Sport] = [
        Sport(name: "Football", symbol: "figure.american.football", coordinate: CLLocationCoordinate2D(latitude: 44.058263, longitude: -123.068521), distance: 500, pitch: 60, heading: 30, games: [Game(opponent: "Spring Game", date: "Apr 27th" , location: "Home"), Game(opponent: "Idaho", date: "Aug 31st" , location: "Home")]),
        
        Sport(name: "Basketball", symbol: "figure.basketball", coordinate: CLLocationCoordinate2D(latitude: 44.044784, longitude: -123.066416), distance: 400, pitch: 60, heading: 0, games: [Game(opponent: "Spring Game", date: "Apr 27th" , location: "Home")]),
        
        Sport(name: "Track & Field", symbol: "figure.track.and.field", coordinate: CLLocationCoordinate2D(latitude: 44.042216, longitude: -123.070818), distance: 400, pitch: 60, heading: 200, games: [Game(opponent: "Spring Game", date: "Apr 27th" , location: "Home")]),
        
        Sport(name: "Baseball", symbol: "figure.baseball", coordinate: CLLocationCoordinate2D(latitude: 44.059034, longitude: -123.065558), distance: 400, pitch: 60, heading: 120, games: [Game(opponent: "Spring Game", date: "Apr 27th" , location: "Home")]),
        
        Sport(name: "Golf", symbol: "figure.golf", coordinate: CLLocationCoordinate2D(latitude: 43.924496, longitude: -123.000396), distance: 400, pitch: 60, heading: 120, games: [Game(opponent: "Spring Game", date: "Apr 27th" , location: "Home")]),
        
        Sport(name: "Tennis", symbol: "figure.tennis", coordinate: CLLocationCoordinate2D(latitude: 44.041484, longitude: -123.073133), distance: 300, pitch: 60, heading: 300, games: [Game(opponent: "Spring Game", date: "Apr 27th" , location: "Home")]),
        
        Sport(name: "Cross Country", symbol: "figure.run", coordinate: CLLocationCoordinate2D(latitude: 44.042216, longitude: -123.070818), distance: 400, pitch: 60, heading: 200, games: [Game(opponent: "Spring Game", date: "Apr 27th" , location: "Home")]),
    ]

    let womensSports: [Sport] = [
        Sport(name: "Track & Field", symbol: "figure.track.and.field", coordinate: CLLocationCoordinate2D(latitude: 44.042216, longitude: -123.070818), distance: 400, pitch: 60, heading: 200, games: [Game(opponent: "Spring Game", date: "Apr 27th" , location: "Home")]),
        Sport(name: "Basketball", symbol: "figure.basketball", coordinate: CLLocationCoordinate2D(latitude: 44.044784, longitude: -123.066416), distance: 400, pitch: 60, heading: 0, games: [Game(opponent: "Spring Game", date: "Apr 27th" , location: "Home")]),
        Sport(name: "Soccer", symbol: "figure.soccer", coordinate: CLLocationCoordinate2D(latitude: 44.057554, longitude: -123.065257), distance: 400, pitch: 60, heading: 120, games: [Game(opponent: "Spring Game", date: "Apr 27th" , location: "Home")]),
        Sport(name: "Volleyball", symbol: "figure.volleyball", coordinate: CLLocationCoordinate2D(latitude: 44.044784, longitude: -123.066416), distance: 400, pitch: 60, heading: 0, games: [Game(opponent: "Spring Game", date: "Apr 27th" , location: "Home")]),
        Sport(name: "Softball", symbol: "figure.softball", coordinate: CLLocationCoordinate2D(latitude: 44.040589, longitude: -123.073416), distance: 400, pitch: 60, heading: 120, games: [Game(opponent: "Spring Game", date: "Apr 27th" , location: "Home")]),
        Sport(name: "Golf", symbol: "figure.golf", coordinate: CLLocationCoordinate2D(latitude: 43.924496, longitude: -123.000396), distance: 400, pitch: 60, heading: 120, games: [Game(opponent: "Spring Game", date: "Apr 27th" , location: "Home")]),
        Sport(name: "Tennis", symbol: "figure.tennis", coordinate: CLLocationCoordinate2D(latitude: 44.041484, longitude: -123.073133), distance: 300, pitch: 60, heading: 300, games: [Game(opponent: "Spring Game", date: "Apr 27th" , location: "Home")]),
        Sport(name: "Lacrosse", symbol: "figure.lacrosse", coordinate: CLLocationCoordinate2D(latitude: 44.057554, longitude: -123.065257), distance: 400, pitch: 60, heading: 120, games: [Game(opponent: "Spring Game", date: "Apr 27th" , location: "Home")]),
        Sport(name: "Cross Country", symbol: "figure.run", coordinate: CLLocationCoordinate2D(latitude: 44.042216, longitude: -123.070818), distance: 400, pitch: 60, heading: 200, games: [Game(opponent: "Spring Game", date: "Apr 27th" , location: "Home")]),
        Sport(name: "Beach Volleyball", symbol: "beach.umbrella.fill", coordinate: CLLocationCoordinate2D(latitude: 44.040589, longitude: -123.073416), distance: 400, pitch: 60, heading: 120, games: [Game(opponent: "Spring Game", date: "Apr 27th" , location: "Home")]),
        Sport(name: "Acrobatics", symbol: "figure.mixed.cardio", coordinate: CLLocationCoordinate2D(latitude: 44.044784, longitude: -123.066416), distance: 400, pitch: 60, heading: 0, games: [Game(opponent: "Spring Game", date: "Apr 27th" , location: "Home")]),
    ]

    var body: some View {
        VStack {
            /// Map View
            MapViewComponent(coordinate: currentMapCoordinate, distance: CLLocationDistance(currentMapDistance), pitch: CGFloat(currentMapPitch), heading: CLLocationDirection(currentMapHeading), isSpinningEnabled: false)
                .frame(height: 400)

            /// Toggle button
            Button(action: {
                isMensSports.toggle()
            }) {
                Text(isMensSports ? "Show Women's Sports" : "Show Men's Sports")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()

            /// Sports Options
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(isMensSports ? mensSports : womensSports, id: \.name) { sport in
                        VStack {
                            Button(action: {
                                currentMapCoordinate = sport.coordinate
                                currentMapDistance = sport.distance
                                currentMapPitch = sport.pitch
                                currentMapHeading = sport.heading
                                selectedSport = sport
                            }){
                            Image(systemName: sport.symbol)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(8)
                                .foregroundColor(Color.blue)
                            }
                            Text(sport.name)
                                .font(.caption)
                                .foregroundColor(Color.secondary)
                        }
                        .padding(.vertical, 4)
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
            }
            
            if let sport = selectedSport {
                Text("\(sport.name) Games")
                    .font(.headline)
                    .padding()

                ScrollView {
                    ForEach(sport.games, id: \.opponent) { game in
                        VStack(alignment: .leading) {
                            Text(game.opponent)
                                .fontWeight(.bold)
                            Text("Date: \(game.date)")
                            Text("Location: \(game.location)")
                        }
                        .padding()
                    }
                }
                .frame(maxHeight: 200)
            }
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct AthleticsDetailView_Preview: PreviewProvider {
    static var previews: some View {
        AthleticsDetailView()
    }
}
