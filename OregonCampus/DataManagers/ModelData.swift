//
//  ModelData.swift
//  OregonCampus
//
//  Created by Oscar Epp on 3/23/24.
//

import Foundation
import Combine

@Observable 
class ModelData{
    var buildings: [Building] = load(filename: "buildingData.json")
}

@Observable
class ModelDataMensTeams {
    var mensTeams: [MensTeams] = load(filename: "mensTeams.json")
}

@Observable
class ModelDataWomensTeams {
    var womensTeams: [WomensTeams] = load(filename: "womensTeams.json")
}

@Observable
class ModelDataBaseball23 {
    var baseball23: [Baseball23] = load(filename: "Baseball23.json")
}




func load<T: Decodable>(  filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else{
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch{
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
    
}

