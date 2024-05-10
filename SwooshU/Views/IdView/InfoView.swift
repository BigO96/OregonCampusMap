//
//  InfoView.swift
//  SwooshU
//
//  Created by Oscar Epp on 4/14/24.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        NavigationView {
            List {
                
                Section(header: Text("About the Developer")) {
                    Text("Developed by Oscar Epp")
                }
                
                Section(header: Text("Links")) {
                    HStack{
                        Button(action: {
                            if let url = URL(string: "https://github.com/BigO96") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Image(systemName: "network")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .foregroundColor(.black)

                        }
                        Button(action: {
                            if let url = URL(string: "https://github.com/BigO96") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Image("github")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                        }
                        .padding(.leading)
                        
                        Button(action: {
                            if let url = URL(string: "https://github.com/BigO96") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Image("linkedin")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                        }
                        .padding(.leading)

                    }
                }
                
                Section(header: Text("Feedback")) {
                    Link("Provide Feedback", destination: URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSd3FQAuGbBYThDTOgaMv0kFFPh_2y9Xh7w9pEqfCBpyW5LJFg/viewform?usp=sf_link")!)
                    Text("Your feedback & questions are valuable. Help us understand your needs and improve the app.")
                }
                Section(header: Text("Copyright")){
                    Text("Copyright © 2024 Oscar Epp. All rights reserved.")
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("App Information")
        }
    }
}

struct FeedbackView: View {
    @State private var feedbackText: String = ""
    
    var body: some View {
        Form {
            Text("We appreciate your feedback. Please let us know your thoughts and suggestions.")
            TextField("Enter your feedback here...", text: $feedbackText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Submit") {
                // Handle feedback submission here
                print("Feedback submitted: \(feedbackText)")
            }
            .disabled(feedbackText.isEmpty)
        }
        .navigationTitle("Feedback")
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
