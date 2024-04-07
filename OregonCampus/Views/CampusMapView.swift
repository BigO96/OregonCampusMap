//
//  CampusMapView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/6/24.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D{
    static let University = CLLocationCoordinate2D(latitude: 44.046593, longitude: -123.076512)
    static let Lillis = CLLocationCoordinate2D(latitude: 44.046030, longitude: -123.077640)
}

struct CampusMapView: View{
    @Environment(ModelData.self) var modelData

    
    
    var body: some View {
        Map{
            Annotation("University Hall", coordinate: .University){
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.background)
                }
            }
//            .annotationTitles(.hidden)
            
            Annotation("Lillis Hall", coordinate: .Lillis){
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.background)
                }
            }
//            .annotationTitles(.hidden)
            
        }
        .mapStyle(.standard(elevation: .realistic))
    }
}


struct CampusMapView_Previews: PreviewProvider {
    static var previews: some View {
        CampusMapView().environment(ModelData())
    }
}
