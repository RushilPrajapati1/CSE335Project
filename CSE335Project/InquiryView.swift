//
//  InquiryView.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 4/17/25.
//

import Foundation
import SwiftUI
import CoreLocation

struct InquiryView: View {
    var property: Property

    @State private var name = ""
    @State private var email = ""
    @State private var message = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Property Inquiry")
                .font(.title2)
                .bold()

            Text("Description")
                .foregroundColor(.gray)
            Text("Inquiring about: \(property.title)")
                .padding()
                .background(Color.pink.opacity(0.1))
                .cornerRadius(8)

            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Text("Add Message")
            TextEditor(text: $message)
                .frame(height: 100)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))

            Spacer()

            Button(action: {
                // Handle sending inquiry
            }) {
                Text("Send Inquiry")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Inquire Screen")
    }
}

