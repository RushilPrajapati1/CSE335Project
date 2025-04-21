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
            VStack(spacing: 16) {
                HStack(spacing: 12) {
                    Image(systemName: "map.circle.fill")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .foregroundColor(.black)

                    Text("Current Listings Nearby")
                        .font(.title2)
                        .bold()
                }
                .padding(.top)

                ZStack(alignment: .bottomTrailing) {
                    Map(coordinateRegion: $mapView.region, annotationItems: mapView.properties) { item in
                        MapAnnotation(coordinate: item.coordinate) {
                            Button {
                                selectedProperty = item
                                navigate = true
                            } label: {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .cornerRadius(12)

                    VStack(spacing: 8) {
                        Button(action: mapView.zoomIn) {
                            Image(systemName: "plus.magnifyingglass")
                                .padding(10)
                                .background(Color.white.opacity(0.9))
                                .clipShape(Circle())
                                .shadow(radius: 2)
                        }

                        Button(action: mapView.zoomOut) {
                            Image(systemName: "minus.magnifyingglass")
                                .padding(10)
                                .background(Color.white.opacity(0.9))
                                .clipShape(Circle())
                                .shadow(radius: 2)
                        }
                    }
                    .padding()
                }
                .frame(height: 600)
                .padding(.horizontal)

                Text("Properties loaded: \(mapView.properties.count)")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                NavigationLink(destination: PropertyListView(properties: $mapView.properties)) {
                    HStack {
                        Image(systemName: "list.bullet.rectangle.portrait")
                        Text("Show Current Properties")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }

                NavigationLink(
                    destination: selectedProperty.map { AnyView(PropertyView(property: $0)) } ?? AnyView(EmptyView()),
                    isActive: $navigate
                ) {
                    EmptyView()
                }
            }
            .onAppear {
                if mapView.properties.isEmpty {
                    mapView.loadProperties(for: "Tempe")
                }
            }
        }
    }
}

#Preview {
    BrowseView()
        .environmentObject(MapModel())
}
