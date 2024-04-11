//
//  TestView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/9/24.
//

import SwiftUI

struct TestView: View {    
    
    @Environment(ModelDataMensTeams.self) var modelDataMensTeams

//    var mensTeams: MensTeams

    
    var body: some View {
        Text(modelDataMensTeams.mensTeams[0].name)
    }
}

#Preview {
    TestView()
        .environment(ModelDataMensTeams())

}
