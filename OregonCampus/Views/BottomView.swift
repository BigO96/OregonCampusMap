//
//  BottomView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/11/24.
//

import SwiftUI

struct BottomView: View {
    @Binding var showBottomSheet: Bool
    @State private var searchText = ""

    var body: some View {
        VStack {
//            pullTab
            BuildingList(showBottomSheet: $showBottomSheet)

        }
        .cornerRadius(40)
        .frame(maxWidth: .infinity)
        .offset(y: showBottomSheet ? UIScreen.main.bounds.height - 800 : UIScreen.main.bounds.height - 210)
        .animation(.easeInOut, value: showBottomSheet)
        .gesture(
            DragGesture().onChanged { value in
                if value.translation.height > 0 {
                    showBottomSheet = false
                } else {
                    showBottomSheet = true
                }
            }
        )
    }

    private var pullTab: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 40, height: 5)
//            .padding()
        }
}


//#Preview {
//    BottomView(isShowing: false)
//}
