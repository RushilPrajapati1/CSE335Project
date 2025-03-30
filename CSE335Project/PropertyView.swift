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
    var property: PropertyModel

    var body: some View {
        VStack(spacing: 10) {
            Text(property.title)
                .font(.title2)
                .bold()

            Text(property.price)
                .font(.headline)
                .foregroundColor(.green)

            Map(coordinateRegion: .constant(
                MKCoordinateRegion(
                    center: property.location,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            ), annotationItems: [property]) { item in
                MapMarker(coordinate: item.location, tint: .red)
            }
            .frame(height: 200)
        }
        .padding()
        .navigationTitle("Property Detail")
    }
}

