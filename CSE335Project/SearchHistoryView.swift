//
//  HistoryView.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/26/25.
//

import SwiftUI

struct SearchHistoryView: View {
    @EnvironmentObject var searchView: SearchModel

    var body: some View {
        VStack {
            Text("Properties You’ve Viewed")
                .font(.headline)

            if searchView.viewed.isEmpty {
                Text("No properties viewed yet.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(searchView.viewed) { property in
                    NavigationLink(destination: PropertyView(property: property)) {
                        VStack(alignment: .leading) {
                            Text(property.title).bold()
                            Text(String(format: "Price: $%.2f", property.price))
                            Text("Location: \(property.location)")
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("Viewed History")
    }
}
