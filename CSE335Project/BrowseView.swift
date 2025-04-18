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
    @State private var navigate = false

    var destinationView: some View {
        if let property = selectedProperty {
            return AnyView(PropertyView(property: property))
        } else {
            return AnyView(Text("No property selected."))
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                Map(coordinateRegion: $mapView.region, annotationItems: mapView.properties, annotationContent: { item in
                    MapAnnotation(coordinate: item.coordinate) {
                        Button {
                            selectedProperty = item
                            navigate = true
                        } label: {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title)
                                .foregroundColor(.blue)
                        }
                    }
                })

                .frame(height: 250)

                NavigationLink(destination: PropertyListView(properties: mapView.properties)) {
                           Text("Show Current Properties")
                               .padding()
                               .frame(maxWidth: .infinity)
                               .background(Color.purple)
                               .foregroundColor(.white)
                               .cornerRadius(10)
                               .padding(.horizontal)
                       }

                NavigationLink(
                    destination: destinationView,
                    isActive: $navigate,
                    label: { EmptyView() }
                )
            }
            .navigationTitle("Current Listings Nearby")
        }
    }
}


//Hello
