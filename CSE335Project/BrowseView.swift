//
//  SearchModel.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/27/25.
//

import Foundation
import SwiftUI
import MapKit

struct BrowseView: View {
    @EnvironmentObject var mapView: MapModel
    @State private var selectedProperty: Property? = nil

    var body: some View {
        VStack {
            Map(coordinateRegion: $mapView.region, annotationItems: mapView.properties) { property in
                MapAnnotation(coordinate: property.coordinate) {
                    Button {
                        selectedProperty = property
                    } label: {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                }
            }
            .frame(height: 250)

            List(mapView.properties) { property in
                VStack(alignment: .leading) {
                    Text(property.title)
                        .font(.headline)
                    Text("Price: $\(String(format: "%.2f", property.price))")
                    Text("Location: \(property.location)")
                }
            }
        }
        .sheet(item: $selectedProperty) { property in
            PropertyView(property: property)
        }
        .navigationTitle("Current Listings Nearby")
    }
}

