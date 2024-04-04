//
//  BuildingMapView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/23/24.
//

import SwiftUI

struct BuildingMapView: View {
    let imageName: String
    @State private var scale: CGFloat = 1.0
    @GestureState private var gestureScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @GestureState private var gestureOffset: CGSize = .zero

    var body: some View {
        GeometryReader { geometry in
            Image(imageName)
                .resizable()
                .scaledToFit() // Adjust to .scaledToFit to respect the original aspect ratio
                .scaleEffect(scale * gestureScale)
                .offset(x: offset.width + gestureOffset.width, y: offset.height + gestureOffset.height)
                .gesture(
                    SimultaneousGesture(
                        MagnificationGesture()
                            .updating($gestureScale, body: { (value, state, _) in
                                state = value
                            })
                            .onEnded { value in
                                self.scale = max(1.0, self.scale * value)
                            },
                        DragGesture()
                            .updating($gestureOffset, body: { (value, state, _) in
                                state = value.translation
                            })
                            .onEnded { value in
                                self.offset = self.adjustOffset(proposedOffset: CGSize(width: self.offset.width + value.translation.width, height: self.offset.height + value.translation.height), geometry: geometry)
                            }
                    )
                )
        }
        .clipped()
        .onAppear {
            // Optionally, calculate and set an initial scale based on the image and view size if needed
        }
    }

    private func adjustOffset(proposedOffset: CGSize, geometry: GeometryProxy) -> CGSize {
        // Calculate the viewable area taking into account the current scale
        let viewWidth = geometry.size.width * scale
        let viewHeight = geometry.size.height * scale

        // Adjust based on your image's aspect ratio and size
        let maxX = max((viewWidth - geometry.size.width) / 2, 0)
        let maxY = max((viewHeight - geometry.size.height) / 2, 0)
        
        return CGSize(
            width: min(max(proposedOffset.width, -maxX), maxX),
            height: min(max(proposedOffset.height, -maxY), maxY)
        )
    }
}

struct BuildingMapView_Preview: PreviewProvider {
    static var previews: some View {
        BuildingMapView(imageName: "UNIVLVL1")
    }
}
