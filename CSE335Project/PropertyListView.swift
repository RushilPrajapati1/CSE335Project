//
//  PropertyListView.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 4/17/25.
//

import Foundation
import SwiftUI

struct PropertyListView: View {
    @Binding var properties: [Property]
    @State private var showingAddProperty = false

    var body: some View {
        List {
            ForEach(properties) { property in
                NavigationLink(destination: PropertyView(property: property)) {
                    VStack(alignment: .leading) {
                        Text(property.title)
                            .font(.headline)
                        Text("Price: $\(String(format: "%.2f", property.price))")
                        Text("Location: \(property.location)")
                        NavigationLink(destination: InquiryView(property: property)) {
                            Text("Inquire")
                                .font(.caption)
                                .padding(6)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                        }
                        .padding(.top, 4)
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationTitle("Properties Nearby")
        .overlay(
            VStack {
                Spacer()
                Button(action: {
                    showingAddProperty = true
                }) {
                    Text("Add more properties")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .padding(.bottom),
            alignment: .bottom
        )
        .sheet(isPresented: $showingAddProperty) {
            AddPropertyView(properties: $properties)
        }
    }
}

#Preview {
    NavigationStack {
        PropertyListView(properties: .constant(Property.sampleData))
    }
}
