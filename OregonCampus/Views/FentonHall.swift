//
//  FentonHall.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/9/24.
//

import SwiftUI
import MapKit

struct FentonHallDetailView: View {
    
    let destinationCoordinate = CLLocationCoordinate2D(latitude: 44.045756, longitude: -123.076438)
    
    let imageNames = ["FentonLVL1", "FentonLVL2", "FentonLVL3", "FentonLVL4", "FentonLVL5"]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                
                /// Title & Button Start
                HStack {
                    Text("Fenton Hall")
                        .font(.title)
                        .padding(.leading)
                    
                    Spacer()
                    
                    DirectionsButton(destinationCoordinate: destinationCoordinate, destinationName: "Fenton Hall")
                }
                .padding([.top, .trailing])
                Divider()
                    .padding()
                
                /// Title & Button End
                /// MapView Start
                MapViewComponent(coordinate: CLLocationCoordinate2D(latitude: 44.045756, longitude: -123.076438), distance: 100, pitch: 80, heading: 0)
                    .frame(width: geometry.size.width - 40, height: 500) // Adjust width based on GeometryReader
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding()
                
                /// MapView End
                /// About Disc Start
                
                VStack {
                    Text("""
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                    """)
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                }
                .frame(width: geometry.size.width - 40)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding(.bottom)
                
                /// About Disc End
                /// Building Map Start
                
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(imageNames, id: \.self) { imageName in
                                Image(imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .frame(width: geometry.size.width - 40, height: 225)
                    .mask(Rectangle().cornerRadius(10))
                }
                /// Building Map End
                /// Hours Start
                
                FentonHours()
                    .scaledToFit()
                    .cornerRadius(10)
                
                /// Hours End
            }
            .background(Color(.systemGray6))
            //        .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    FentonHallDetailView()
}
