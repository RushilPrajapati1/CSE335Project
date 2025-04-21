//
//  Property.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/27/25.
//

import Foundation
import MapKit


struct Property: Identifiable {
    let id = UUID()
    let title: String
    let price: Double
    let location: String
    let coordinate: CLLocationCoordinate2D

    static let sampleData: [Property] = [
        Property(
            title: "Downtown Tempe Apartment",
            price: 1600,
            location: "101 S Mill Ave, Tempe, AZ",
            coordinate: CLLocationCoordinate2D(latitude: 33.4260, longitude: -111.9398)
        ),
        Property(
            title: "University Townhouse",
            price: 1800,
            location: "525 E Apache Blvd, Tempe, AZ",
            coordinate: CLLocationCoordinate2D(latitude: 33.4172, longitude: -111.9281)
        ),
        Property(
            title: "Luxury Scottsdale Rental",
            price: 2300,
            location: "7401 E Camelback Rd, Scottsdale, AZ",
            coordinate: CLLocationCoordinate2D(latitude: 33.5013, longitude: -111.9251)
        )
    ]
}
