import Foundation
import CoreLocation

struct GooglePlacesResponse: Codable {
    let results: [GooglePlace]
}

struct GooglePlace: Codable, Identifiable {
    var id: String { place_id }

    let name: String
    let geometry: Geometry
    let place_id: String
    let vicinity: String?
}

struct Geometry: Codable {
    let location: Location
}

struct Location: Codable {
    let lat: Double
    let lng: Double
}

