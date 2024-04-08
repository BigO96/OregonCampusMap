////
////  BuildingServices.swift
////  OregonCampus
////
////  Created by Oscar Epp on 4/7/24.
//// TRYING TO MAKE INTO SEPERATE FILE
//
//import SwiftUI
//
//struct BuildingServices: View {
//    
//    
//    let typeDescriptions: [String: String] = [
//        "cup.and.saucer": "Café",
//        "books.vertical": "Library",
//        "studentdesk": "Study Area",
//        "fork.knife": "Dining",
//        "bed.double": "Housing",
//        "sports": "Sports Facility",
//        "tshirt": "Duck Store",
//        "cart.fill": "Shopping",
//        "printer": "Printing",
//        "tutoring": "Tutoring Center"
//    ]
//    
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 10) {
//                ForEach(building.type, id: \.self) { type in
//                    VStack {
//                        Image(systemName: type)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 30, height: 30)
//                            .padding()
//                            .background(Color.blue.opacity(0.1))
//                            .cornerRadius(8)
//                            .foregroundColor(Color.blue)
//                        
//                        Text(typeDescriptions[type] ?? "Unknown")
//                            .font(.caption)
//                            .foregroundColor(Color.secondary)
//                    }
//                    .padding(.vertical, 4)
//                    //                            .background(Color.gray.opacity(0.2)) // Background for the whole VStack
//                    .cornerRadius(12)
//                }
//            }
//            .padding(.horizontal)
//        }
//    }
//}
//
////#Preview {
////    BuildingServices()
////}
