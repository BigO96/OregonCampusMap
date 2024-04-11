//
//  Games.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/10/24.
//

import Foundation
import Combine
import SwiftUI
import MapKit


struct Baseball23: Hashable, Codable, Identifiable{
    var id: Int
    let Event: String
    let StartDate: String
    let StartTime: String
    let EndDate: String
    let EndTime: String
    let Location: String
    let Result: String
}

