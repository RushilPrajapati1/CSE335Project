//
//  PropertyListView.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 4/17/25.
//

import Foundation
import SwiftUI

//import SwiftUI

struct PropertyListView: View {
    var properties: [Property]

    var body: some View {
        VStack {
            List(properties) { property in
                VStack(alignment: .leading, spacing: 6) {
                    Text(property.title)
                        .font(.headline)
                    Text("Price: $\(String(format: "%.2f", property.price))")
                    Text("Location: \(property.location)")

                    HStack {
                        Spacer()
                        NavigationLink(destination: PropertyView(property: property)) {
                            Text("Inquire")
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                        }
                    }
                }
                .padding(.vertical, 4)
            }

            Button(action: {
            }) {
                Text("Add more properties")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Properties Nearby")
    }
}

#Preview {
    NavigationStack {
        PropertyListView(properties: Property.sampleData)
    }
}
