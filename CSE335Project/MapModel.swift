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

    init() {
        loadSampleProperties()
    }

    func loadSampleProperties() {
        properties = Property.sampleData
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
