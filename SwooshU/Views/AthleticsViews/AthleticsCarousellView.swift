//
//  AthleticsCarousellView.swift
//  SwooshU
//
//  Created by Oscar Epp on 4/13/24.
//

import SwiftUI
import MapKit

struct AthleticsCarouselView: View {
    @EnvironmentObject var teamDataLocal: TeamData
    
    @Binding var isMensSports: Bool
    @Binding var SelectedTeam: String
    @Binding var currentMapCoordinate: CLLocationCoordinate2D
    @Binding var currentMapDistance: Int
    @Binding var currentMapPitch: Int
    @Binding var currentMapHeading: Int
    
    var body: some View {
        HStack{
            Button(action: {
                isMensSports.toggle()
            }) {
                VStack {
                    Image(systemName: isMensSports ? "mustache.fill" : "mouth.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                        .foregroundColor(Color.blue)
                    
                    Text(isMensSports ? "Men's" : "Women's")
                        .font(.caption)
                        .foregroundColor(Color.secondary)
                }
                .padding(.leading, 10)
                .cornerRadius(12)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(isMensSports ? teamDataLocal.mensTeams : teamDataLocal.womensTeams) { team in
                        Button(action: {
                            self.SelectedTeam = team.name
                            self.currentMapCoordinate = team.locationCoordinate
                            self.currentMapDistance = team.distance
                            self.currentMapPitch = team.pitch
                            self.currentMapHeading = team.heading
                        }) {
                            VStack {
                                Image(systemName: team.symbol)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .padding()
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(8)
                                    .foregroundColor(Color.blue)
                                
                                Text(team.name)
                                    .font(.caption)
                                    .foregroundColor(Color.secondary)
                            }
                            .padding(.vertical, 4)
                            .cornerRadius(12)
                            
                        }
                    }
                }
                .padding(.trailing, 10)
            }
        }
    }
}


//struct AthleticsCarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        AthleticsCarouselView(SelectedTeam: .constant("Track & Field"))
//            .environmentObject(TeamData())
//    }
//}
//
