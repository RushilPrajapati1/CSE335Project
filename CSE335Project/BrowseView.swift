//
//  SearchModel.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/27/25.
//

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
                Spacer().frame(height: 10)
                Text("Current Listings Nearby")
                    .font(.title)
                    .bold()

                ZStack(alignment: .bottomTrailing) {
                    Map(
                        initialPosition: .region(mapView.region),
                        interactionModes: [.all],
                        content: {
                            ForEach(mapView.properties) { property in
                                Annotation("\(property.title)", coordinate: property.coordinate) {
                                    Button {
                                        selectedProperty = property
                                        navigate = true
                                    } label: {
                                        Image(systemName: "mappin.circle.fill")
                                            .font(.title)
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                        }
                    )
                    .mapControls { MapUserLocationButton() }
                    .frame(height: 600)
                    .cornerRadius(12)

                    VStack(spacing: 8) {
                        Button(action: { mapView.zoomIn() }) {
                            Image(systemName: "plus.magnifyingglass")
                                .padding(10)
                                .background(Color.white.opacity(0.8))
                                .clipShape(Circle())
                        }
                        Button(action: { mapView.zoomOut() }) {
                            Image(systemName: "minus.magnifyingglass")
                                .padding(10)
                                .background(Color.white.opacity(0.8))
                                .clipShape(Circle())
                        }
                    }.padding()
                }
                .padding(.horizontal)

                NavigationLink(destination:
                    PropertyListView(properties: mapView.properties)) {
                    Text("Show Current Properties")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                NavigationLink(destination: destinationView, isActive: $navigate) {
                    EmptyView()
                }
            }
        }
    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView()
            .environmentObject(MapModel())
    }
}
