//
//  PropertyView.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/26/25.
//

import SwiftUI
import MapKit

struct PropertyView: View {
    var property: Property

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(property.title)
                        .font(.title)
                        .bold()

                    HStack(spacing: 8) {
                        Image(systemName: "dollarsign.circle")
                        Text(String(format: "$%.2f / month", property.price))
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)

                    HStack(spacing: 8) {
                        Image(systemName: "mappin.and.ellipse")
                        Text(property.location)
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)
                }

                Map(initialPosition: .region(
                    MKCoordinateRegion(center: property.coordinate,
                                       span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
                    interactionModes: [.all]
                ) {
                    Marker(property.title, coordinate: property.coordinate)
                }
                .frame(height: 300)
                .cornerRadius(12)

                NavigationLink(destination: InquiryView(property: property)) {
                    HStack {
                        Image(systemName: "envelope.fill")
                        Text("Inquire")
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
        .navigationTitle("Property Details")
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    NavigationStack {
        PropertyView(property: Property.sampleData.first!)
    }
}
