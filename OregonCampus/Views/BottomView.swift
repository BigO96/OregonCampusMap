//
//  BottomView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/11/24.
//

import SwiftUI

struct BottomView: View {
    @Binding var showBottomSheet: Bool
    @State private var offset = CGFloat.zero

    struct Constants {
        static let minimizedHeight: CGFloat = 210
        static let maximizedHeight: CGFloat = 800
    }

    var body: some View {
        VStack {
            pullTab
            BuildingList(showBottomSheet: $showBottomSheet)
        }
        .background(Color(.systemBackground))
        .cornerRadius(40)
        .frame(maxWidth: .infinity)
        .offset(y: getOffset())
        .animation(.interactiveSpring(response: 0.35, dampingFraction: 0.85, blendDuration: 1), value: offset)
        .gesture(
            DragGesture().onChanged { value in
                self.offset = value.translation.height
            }
            .onEnded { value in
                withAnimation(.spring()) {
                    if offset > 50 || value.predictedEndTranslation.height > 50 {
                        showBottomSheet = false
                        offset = 0
                    } else if offset < -50 || value.predictedEndTranslation.height < -50 {
                        showBottomSheet = true
                        offset = 0
                    } else {
                        // Adjusted using named constants
                        offset = showBottomSheet ? 0 : UIScreen.main.bounds.height - Constants.minimizedHeight - (UIScreen.main.bounds.height - Constants.maximizedHeight)
                    }
                }
            }
        )
    }

    private func getOffset() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        if showBottomSheet {
            return screenHeight - Constants.maximizedHeight + offset
        } else {
            return screenHeight - Constants.minimizedHeight + min(offset, 0)
        }
    }

    private var pullTab: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 40, height: 5)
            .foregroundColor(.gray)
            .padding(.top, 8)
    }
}
