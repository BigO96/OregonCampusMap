//
//  ContentView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/13/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: KnightLibraryDetailView()) {
                    Text("Knight Library")
                }
                NavigationLink(destination: LawrenceHallDetailView()) {
                    Text("Lawrence Hall")
                }
                NavigationLink(destination: LilisHallDetailView()) {
                    Text("Lilis Hall")
                }
                NavigationLink(destination: McKenzieHallDetailView()) {
                    Text("McKenzie Hall")
                }
                NavigationLink(destination: CondonHallDetailView()) {
                    Text("Condon Hall")
                }
                NavigationLink(destination: FentonHallDetailView()) {
                    Text("Fenton Hall")
                }
                NavigationLink(destination: GerlingerHallDetailView()) {
                    Text("Gerlinger Hall")
                }
                NavigationLink(destination: EMUDetailView()) {
                    Text("Erb Memorial Union (EMU)")
                }
                NavigationLink(destination: UniversityHallDetailView()) {
                    Text("University Hall")
                }
                NavigationLink(destination: StudentRecreationCenterDetailView()) {
                    Text("Student Recreation Center")
                }
                NavigationLink(destination: JohnEJaquaDetailView()) {
                    Text("John E. Jaqua Center")
                }
                NavigationLink(destination: UnthankHallDetailView()) {
                    Text("Unthank Hall")
                }
                NavigationLink(destination: TykesonHallDetailView()) {
                    Text("Tykeson Hall")
                }
                Text("Other:")
                NavigationLink(destination: NewView()) {
                    Text("New View")
                }
            }
            .navigationTitle("Oregon Campus")
        }
    }
}

#Preview {
    ContentView()
}
