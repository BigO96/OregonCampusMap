//
//  TestView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/9/24.
//

import SwiftUI

struct ScheduleView: View {
    @State private var currentSport = "Tennis"
    @State private var selectedSortOption = "Season"
    @State private var selectedYear = Calendar.current.component(.year, from: Date()) // Default to current year
    let sortOptions = ["Season", "Upcoming"]
    let years: [Int] = Array(2020...2024) // Example range of years

    var body: some View {
        VStack {
            HStack {
                Text("\(currentSport) Schedule")
                    .font(.title)
                    .padding(.horizontal, 20)
                Spacer()
            }
            .padding(.top)

            HStack {
                Picker("Year", selection: $selectedYear) {
                    ForEach(years, id: \.self) { year in
                        Text("\(String(year))").tag(year)
                    }
                }
                .pickerStyle(MenuPickerStyle())

                Picker("Sort by", selection: $selectedSortOption) {
                    ForEach(sortOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding()

            // Your schedule list or content goes here, using the selectedYear and selectedSortOption to determine sorting

        }
        .padding(.top)
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
