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
                Section(header: Text("About the App")) {
                    Text("Oregon Campus is your one-stop solution for navigating campus life. From keeping track of events to managing your ID, this app makes campus life effortless.")
                }
                
                Section(header: Text("About the Developer")) {
                    Text("Developed by Oscar Epp, a dedicated developer with a passion for creating educational tools that enhance student life. Oscar is always looking to innovate and improve the college experience through technology.")
                }
                
                Section(header: Text("Feedback")) {
                    Link("Provide Feedback", destination: URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSd3FQAuGbBYThDTOgaMv0kFFPh_2y9Xh7w9pEqfCBpyW5LJFg/viewform?usp=sf_link")!)
                    Text("Your feedback is valuable to us. It helps us understand your needs and improve the app.")
                }
                Section(){
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
