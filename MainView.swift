//
//  MainView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/13/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            // Add other components of your main view here
            Text("Oregon Campus")
                .font(.largeTitle)
                .padding()

            // Container for the PanZoomView
            ZStack {
                // The background of the container, change color and cornerRadius as needed
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2)) // Container background color

                // PanZoomView placed inside the container
                PanZoomView()
                    .clipShape(RoundedRectangle(cornerRadius: 10)) // Optional: Clips the PanZoomView to match the container shape
                    .padding(10) // Adjust the padding to control the size of the PanZoomView inside the container
            }
            .frame(width: 300, height: 300) // Set the size of the container

            // Add more components to your main view if needed
        }
        .padding()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
