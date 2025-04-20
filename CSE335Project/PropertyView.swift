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
                Text(property.title)
                    .font(.title)
                    .bold()

                Text("Price: $\(String(format: "%.2f", property.price))")
                Text("Location: \(property.location)")

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
                    Text("Inquire")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle("Property Details")
    }
}
