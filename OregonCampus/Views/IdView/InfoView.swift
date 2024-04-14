//
//  InfoView.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/14/24.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("About the App")) {
                    Text("Oregon Campus is your one-stop solution for navigating campus life. From keeping track of events to managing your ID, this app makes campus life effortless and fun.")
                }
                
                Section(header: Text("About the Developer")) {
                    Text("Developed by Oscar Epp, a dedicated developer with a passion for creating educational tools that enhance student life. Oscar is always looking to innovate and improve the college experience through technology.")
                }
                
                Section(header: Text("Feedback")) {
                    NavigationLink("Provide Feedback", destination: FeedbackView())
                    Text("Your feedback is valuable to us. It helps us understand your needs and improve the app.")
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