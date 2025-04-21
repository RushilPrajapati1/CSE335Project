//
//  InquiryDetailView.swift
//  CSE335Project
//
//  Created by Shubham Khalkho on 4/20/25.
//

import SwiftUI
import MapKit

struct InquiryDetailView: View {
    var property: Property

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Inquiry Details")
                .font(.title)
                .bold()

            Text("Title: \(property.title)")
            Text(String(format: "Price: $%.2f", property.price))
            Text("Location: \(property.location)")

            Map(coordinateRegion: .constant(
                MKCoordinateRegion(
                    center: property.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                )
            ), annotationItems: [property]) { _ in
                MapMarker(coordinate: property.coordinate)
            }
            .frame(height: 200)
            .cornerRadius(12)

            Text("Your inquiry for this property was submitted successfully.")
                .foregroundColor(.gray)
                .padding(.top)

            Spacer()
        }
        .padding()
        .navigationTitle("Inquiry Summary")
    }
}

#Preview {
    NavigationStack {
        InquiryDetailView(property: Property.sampleData.first!)
    }
}

