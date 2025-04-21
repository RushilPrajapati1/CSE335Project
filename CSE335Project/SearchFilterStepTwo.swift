//
//  SearchFilterStepTwo.swift
//  CSE335Project
//
//  Created by Shubham Khalkho on 4/20/25.
//
import SwiftUI
import MapKit

struct SearchFilterStepTwo: View {
    var city: String
    var price: Double

    @EnvironmentObject var mapView: MapModel
    @EnvironmentObject var searchView: SearchModel

    @State private var beds: Int = 1
    @State private var roomType: String = "Private"
    @State private var showMap = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var selectedProperty: Property? = nil

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.4255, longitude: -111.94),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        VStack(spacing: 16) {
            Text("More Filters")
                .font(.title2)
                .bold()

            Stepper("Beds: \(beds)", value: $beds, in: 1...5)

            Picker("Room Type", selection: $roomType) {
                Text("Private").tag("Private")
                Text("Shared").tag("Shared")
            }
            .pickerStyle(SegmentedPickerStyle())

            Button("Search") {
                let geocoder = CLGeocoder()
                let locale = Locale(identifier: "en_US")

                geocoder.geocodeAddressString(city, in: nil, preferredLocale: locale) { placemarks, error in
                    if let placemark = placemarks?.first {
                        guard placemark.isoCountryCode == "US" else {
                            DispatchQueue.main.async {
                                errorMessage = "City is outside the USA."
                                showError = true
                            }
                            return
                        }
                        guard let coordinate = placemark.location?.coordinate else {
                            DispatchQueue.main.async {
                                errorMessage = "Could not determine coordinates for \(city)."
                                showError = true
                            }
                            return
                        }
                        DispatchQueue.main.async {
                            let newRegion = MKCoordinateRegion(
                                center: coordinate,
                                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                            )
                            region = newRegion
                            mapView.region = newRegion
                            showMap = true
                        }

                        // Load and filter by price
                        mapView.loadProperties(for: city)

                        // Wait a short delay to apply price filter after properties load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            mapView.properties = mapView.properties.filter { $0.price <= price }
                        }

                    } else {
                        DispatchQueue.main.async {
                            errorMessage = "City doesn't exist."
                            showError = true
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(10)
            .alert("Error", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }

            if showMap {
                Map(coordinateRegion: $mapView.region, annotationItems: mapView.properties) { property in
                    MapAnnotation(coordinate: property.coordinate) {
                        Button {
                            selectedProperty = property
                        } label: {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title2)
                                .foregroundColor(.red)
                        }
                    }
                }
                .frame(height: 400)
                .cornerRadius(12)
                .sheet(item: $selectedProperty) { property in
                    NavigationStack {
                        PropertyInfoView(property: property)
                            .environmentObject(searchView)
                    }
                    .onAppear {
                        searchView.addToViewed(property)
                    }
                }
            }
        }
        .padding()
    }
}

struct PropertyInfoView: View {
    var property: Property
    @EnvironmentObject var searchView: SearchModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(property.title)
                .font(.title)
                .bold()

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
            .cornerRadius(8)

            Spacer()

            NavigationLink(destination: InquiryView(property: property)
                            .environmentObject(searchView)) {
                Text("Send Inquiry")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationTitle("Details")
    }
}

#Preview {
    NavigationStack {
        SearchFilterStepTwo(city: "Tempe", price: 2500)
            .environmentObject(MapModel())
            .environmentObject(SearchModel())
    }
}
