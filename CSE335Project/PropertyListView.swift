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
        VStack(spacing: 0) {
            List {
                ForEach(properties.indices, id: \.self) { index in
                    let property = properties[index]
                    NavigationLink(destination: PropertyView(property: property)) {
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "house.fill")
                                .font(.title2)
                                .foregroundColor(.black)
                                .padding(8)
                                .background(Color(.systemGray5))
                                .clipShape(RoundedRectangle(cornerRadius: 10))

                            VStack(alignment: .leading, spacing: 4) {
                                Text(property.title)
                                    .font(.headline)

                                Text(String(format: "$%.2f / month", property.price))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                                Text(property.location)
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                NavigationLink(destination: InquiryView(property: property)) {
                                    Label("Inquire", systemImage: "envelope.fill")
                                        .font(.caption)
                                        .padding(6)
                                        .background(Color.black)
                                        .foregroundColor(.white)
                                        .cornerRadius(6)
                                }
                                .padding(.top, 4)
                            }
                        }
                        .padding(.vertical, 6)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                        .animation(.easeOut.delay(Double(index) * 0.05), value: properties.count)
                    }
                }
            }
            .listStyle(.plain)

            Button(action: {
                withAnimation(.spring()) {
                    showingAddProperty = true
                }
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "plus.circle.fill")
                    Text("Add More Properties")
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding()
                .shadow(radius: 4, y: 2)
            }
            .sheet(isPresented: $showingAddProperty) {
                AddPropertyView(properties: $properties)
            }
        }
        .navigationTitle("Nearby Properties")
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    NavigationStack {
        PropertyListView(properties: .constant(Property.sampleData))
    }
}
