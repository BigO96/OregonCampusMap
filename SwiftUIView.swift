//
//  SwiftUIView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/13/24.
//

import SwiftUI

struct PanZoomView: View {
    @State private var scale: CGFloat = 1.0
    @State private var lastScaleValue: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Drawing the building with rooms
            GeometryReader { geometry in
                let buildingWidth = geometry.size.width / 2
                let buildingHeight = geometry.size.height / 2
                
                // Building Background
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: buildingWidth, height: buildingHeight)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                
                // Rooms - You can add more or adjust as necessary
                ForEach(0..<4) { row in
                    ForEach(0..<2) { column in
                        Rectangle()
                            .fill(Color.blue.opacity(0.8))
                            .frame(width: buildingWidth / 2 - 10, height: buildingHeight / 4 - 10)
                            .position(
                                x: (CGFloat(column) * buildingWidth / 2) + buildingWidth / 4,
                                y: (CGFloat(row) * buildingHeight / 4) + buildingHeight / 8 + (geometry.size.height - buildingHeight) / 2
                            )
                    }
                }
            }
            .scaleEffect(scale)
            .offset(x: offset.width, y: offset.height)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        let delta = value / self.lastScaleValue
                        self.scale *= delta
                        self.lastScaleValue = value
                    }
                    .onEnded { _ in
                        self.lastScaleValue = 1.0
                    }
                    .simultaneously(with: DragGesture()
                        .onChanged { value in
                            self.offset = CGSize(width: self.lastOffset.width + value.translation.width, height: self.lastOffset.height + value.translation.height)
                        }
                        .onEnded { _ in
                            self.lastOffset = self.offset
                        })
            )
            .edgesIgnoringSafeArea(.all) // Ensure view uses the full screen, adjust if needed
        }
    }
}

struct PanZoomView_Previews: PreviewProvider {
    static var previews: some View {
        PanZoomView()
    }
}
