//
//  PropertyView.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/26/25.
//
import Foundation
import SwiftUI
import MapKit

struct PropertyView: View {
    var property: Property

    var body: some View {
        VStack(spacing: 10) {
            Text(property.title)
                .font(.title2)
                .bold()

            Text("Price: $\(String(format: "%.2f", property.price))")

            Map(coordinateRegion: .constant(
                MKCoordinateRegion(
                    center: property.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            ), annotationItems: [property]) { item in
                MapMarker(coordinate: item.coordinate, tint: .red)
            }
            .frame(height: 200)
            NavigationLink(destination: InquiryView(property: property)) {
                        Text("Send Inquiry")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top)

                    Spacer()
        }
        .padding()
        .navigationTitle("Property Detail")
    }
}

