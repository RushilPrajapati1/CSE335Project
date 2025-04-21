//
//  HistoryView.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/26/25.
//

import Foundation
import SwiftUI

struct SearchHistoryView: View {
    @EnvironmentObject var searchView: SearchModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 10) {
                Image(systemName: "clock.arrow.circlepath")
                    .font(.title2)
                    .foregroundColor(.black)
                Text("Viewed Properties")
                    .font(.title2)
                    .bold()
            }
            .padding(.top)
            .transition(.opacity.combined(with: .move(edge: .top)))

            if searchView.viewed.isEmpty {
                Spacer()
                VStack(spacing: 12) {
                    Image(systemName: "eye.slash")
                        .resizable()
                        .frame(width: 60, height: 50)
                        .foregroundColor(.gray)
                    Text("No properties viewed yet.")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity)
            } else {
                List(searchView.viewed.indices, id: \.self) { index in
                    let property = searchView.viewed[index]
                    NavigationLink(destination: PropertyView(property: property)) {
                        HStack(spacing: 12) {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .font(.title3)
                                .foregroundColor(.blue)
                            VStack(alignment: .leading) {
                                Text(property.title).bold()
                                Text(String(format: "$%.2f", property.price))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text(property.location)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 6)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                        .animation(.easeOut.delay(Double(index) * 0.04), value: searchView.viewed.count)
                    }
                }
                .listStyle(.plain)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Search History")
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    SearchHistoryView()
        .environmentObject(MapModel())
        .environmentObject(SearchModel())
}

