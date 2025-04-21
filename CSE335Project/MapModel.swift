//
//  MapModel.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/27/25.
//

import MapKit
import Foundation

class MapModel: ObservableObject {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.4255, longitude: -111.9400),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    @Published var properties: [Property] = []

    private let apiKey = "AIzaSyBS4mMa3Yh4cFweYHMkm84q08nRCE587F4"

    func loadSampleProperties() {
        properties = Property.sampleData
    }

    func loadProperties(for locationQuery: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationQuery) { placemarks, error in
            guard error == nil, let location = placemarks?.first?.location else {
                print("❌ Geocoding failed for: \(locationQuery)")
                return
            }

            DispatchQueue.main.async {
                self.region.center = location.coordinate
            }

            let locationString = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
            let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(locationString)&radius=3000&keyword=apartment&key=\(self.apiKey)"

            guard let url = URL(string: urlString) else { return }

            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else {
                    print("❌ Network error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                // Debug: Print raw JSON to console
                print("📦 Raw JSON:")
                print(String(data: data, encoding: .utf8) ?? "No JSON string")

                do {
                    let decoded = try JSONDecoder().decode(GooglePlacesResponse.self, from: data)

                    let mapped = decoded.results.compactMap { result -> Property? in
                        let lat = result.geometry.location.lat
                        let lng = result.geometry.location.lng
                        guard lat.isFinite, lng.isFinite else { return nil }

                        return Property(
                            title: result.name,
                            price: Double.random(in: 1000...3000),
                            location: result.vicinity ?? "Unknown Location",
                            coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng)
                        )
                    }

                    DispatchQueue.main.async {
                        self.properties = mapped
                        print("✅ Loaded \(mapped.count) properties")
                    }
                } catch {
                    print("❌ Decoding error: \(error)")
                    print("➡️ Raw Data:\n" + (String(data: data, encoding: .utf8) ?? "Unreadable"))
                }
            }.resume()
        }
    }

    func zoomIn() {
        region.span.latitudeDelta /= 2
        region.span.longitudeDelta /= 2
    }

    func zoomOut() {
        region.span.latitudeDelta *= 2
        region.span.longitudeDelta *= 2
    }
}
