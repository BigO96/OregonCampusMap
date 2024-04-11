//
//  BottomView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/11/24.
//

import SwiftUI

struct BottomView: View {
    @Binding var isShowing: Bool
    @State private var searchText = ""

    var body: some View {
        VStack {
//            pullTab
            BuildingList()
        }
        .cornerRadius(40)
        .frame(maxWidth: .infinity)
        .offset(y: isShowing ? UIScreen.main.bounds.height - 400 : UIScreen.main.bounds.height - 120)
        .animation(.easeInOut, value: isShowing)
        .gesture(
            DragGesture().onChanged { value in
                if value.translation.height > 0 {
                    isShowing = false
                } else {
                    isShowing = true
                }
            }
        )
    }

    private var pullTab: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 40, height: 5)
            .padding()
    }
}


//#Preview {
//    BottomView(isShowing: false)
//}
