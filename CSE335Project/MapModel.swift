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
        span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.02)
    )

    @Published var properties: [Property] = []
    
    private let apiKey = "AIzaSyBS4mMa3Yh4cFweYHMkm84q08nRCE587F4" // <== paste your key here


    init() {
       // loadSampleProperties()
        loadProperties()
    }

    func loadSampleProperties() {
        properties = Property.sampleData
    }
    
    func loadProperties(){
        let location = "\(region.center.latitude),\(region.center.longitude)"
                let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(location)&radius=3000&type=apartment&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
                    guard let data = data, error == nil else { return }

            do {
                            let decoded = try JSONDecoder().decode(GooglePlacesResponse.self, from: data)
                            DispatchQueue.main.async {
                                self.properties = decoded.results.map {
                                    Property(
                                        title: $0.name,
                                        price: Double.random(in: 1000...3000), // fake price
                                        location: $0.vicinity,
                                        coordinate: CLLocationCoordinate2D(
                                            latitude: $0.geometry.location.lat,
                                            longitude: $0.geometry.location.lng
                                        )
                                    )
                                }
                            }
                self.properties.forEach { print($0.title) }
                        } catch {
                            print("Error decoding JSON: \(error)")
                        }
                    }.resume()

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
