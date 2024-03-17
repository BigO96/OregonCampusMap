//
//  FentonHours.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/15/24.
//

import SwiftUI

struct FentonHours: View {
    // Example operating hours (24-hour format)
    let libraryHours = (open: 8, close: 22) // Open from 8:00 to 22:00
    let coffeeHours = (open: 7, close: 18) // Open from 7:00 to 18:00
    let designPrintingHours = (open: 9, close: 17) // Open from 9:00 to 17:00

    var body: some View {
        List {
            itemRow(systemIcon: "building.columns", title: "Library", hours: libraryHours)
            itemRow(systemIcon: "cup.and.saucer", title: "Coffee", hours: coffeeHours)
            itemRow(systemIcon: "printer", title: "Design Printing", hours: designPrintingHours)
        }
    }
    
    @ViewBuilder
    private func itemRow(systemIcon: String, title: String, hours: (open: Int, close: Int)) -> some View {
        HStack {
            Image(systemName: systemIcon)
                .font(.system(size: 25))
            Text(title)
                .font(.system(size: 15))
            
            Spacer()
            
            Text(isOpen(hours: hours) ? "Open" : "Closed")
                .font(.system(size: 15))
                .foregroundColor(isOpen(hours: hours) ? .green : .red)
        }
    }
    
    private func isOpen(hours: (open: Int, close: Int)) -> Bool {
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        
        return hour >= hours.open && hour < hours.close
    }
}

// For Preview
struct FentonHours_Previews: PreviewProvider {
    static var previews: some View {
        FentonHours()
    }
}

