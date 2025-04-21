//
//  InquiryView.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 4/17/25.
//

import Foundation
import SwiftUI

struct InquiryView: View {
    var property: Property
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var searchView: SearchModel

    @State private var name = ""
    @State private var email = ""
    @State private var message = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 10) {
                    Image(systemName: "envelope.fill")
                        .font(.title2)
                        .foregroundColor(.black)
                    Text("Property Inquiry")
                        .font(.title2)
                        .bold()
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Inquiring about:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(property.title)
                        .bold()
                }

                Group {
                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Text("Add Message")
                    TextEditor(text: $message)
                        .frame(height: 100)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }

                Button(action: {
                    searchView.addToHistory(property)
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "paperplane.fill")
                        Text("Send Inquiry")
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Inquire")
    }
}

#Preview {
    NavigationStack {
        InquiryView(property: Property.sampleData.first!)
            .environmentObject(SearchModel())
    }
}
