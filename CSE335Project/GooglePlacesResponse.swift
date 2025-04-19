import Foundation

struct GooglePlacesResponse: Codable {
    let results: [Place]
}

struct Place: Codable {
    let name: String
    let vicinity: String
    let geometry: Geometry
}

struct Geometry: Codable {
    let location: Location
}

struct Location: Codable {
    let lat: Double
    let lng: Double
}

