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

    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 10)
                Text("Current Listings Nearby")
                    .font(.title)
                    .bold()

                ZStack(alignment: .bottomTrailing) {
                    Map(coordinateRegion: $mapView.region, annotationItems: mapView.properties) { item in
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
                    }
                    .cornerRadius(12)

                    VStack(spacing: 8) {
                        Button(action: {
                            mapView.zoomIn()
                        }) {
                            Image(systemName: "plus.magnifyingglass")
                                .padding(10)
                                .background(Color.white.opacity(0.8))
                                .clipShape(Circle())
                        }
                        Button(action: {
                            mapView.zoomOut()
                        }) {
                            Image(systemName: "minus.magnifyingglass")
                                .padding(10)
                                .background(Color.white.opacity(0.8))
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                }
                .frame(height: 600)
                .padding()

                Text("Properties loaded: \(mapView.properties.count)")
                    .font(.subheadline)
                    .padding(.bottom)

                NavigationLink(destination: PropertyListView(properties: $mapView.properties)) {
                    Text("Show Current Properties")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                NavigationLink(
                    destination: selectedProperty.map { AnyView(PropertyView(property: $0)) } ?? AnyView(Text("No property selected.")),
                    isActive: $navigate
                ) {
                    EmptyView()
                }
            }
            .onAppear {
                if mapView.properties.isEmpty {
                    mapView.loadProperties(for: "Tempe") // Default or pass from search
                }
            }
        }
    }
}

#Preview {
    BrowseView()
        .environmentObject(MapModel())
}
