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

    @State private var beds: Int = 1
    @State private var roomType: String = "Private"
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.4255, longitude: -111.94),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var properties: [Property] = []

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
                performSearch()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(10)

            Map(coordinateRegion: $region, annotationItems: properties) { property in
                MapAnnotation(coordinate: property.coordinate) {
                    Image(systemName: "house.fill")
                        .foregroundColor(.red)
                }
            }
            .frame(height: 400)
        }
        .padding()
    }

    func performSearch() {
        properties = Property.sampleData.filter { property in
            property.location.lowercased().contains(city.lowercased()) &&
            property.price <= price &&
            (roomType == "Shared" || roomType == "Private")
        }
    }
}

#Preview {
    SearchFilterStepTwo(city: "Tempe", price: 2500)
}
