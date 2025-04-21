//
//  AddPropertyView.swift
//  CSE335Project
//
//  Created by Shubham Khalkho on 4/18/25.
//

import SwiftUI
import MapKit
import SwiftUI

struct AddPropertyView: View {
    @Binding var properties: [Property]
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var searchView: SearchModel

    @State private var title = ""
    @State private var price = ""
    @State private var location = ""
    @State private var address = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack(spacing: 10) {
                    Image(systemName: "plus.rectangle.on.folder.fill")
                        .font(.title2)
                        .foregroundColor(.black)
                    Text("Add Property")
                        .font(.largeTitle).bold()
                }

                Text("Property Details")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Group {
                    LabeledField(icon: "tag.fill", placeholder: "Title", text: $title)
                    LabeledField(icon: "dollarsign.circle.fill", placeholder: "Price", text: $price, keyboard: .decimalPad)
                    LabeledField(icon: "location.fill", placeholder: "Location", text: $location)
                    LabeledField(icon: "house.fill", placeholder: "Street Address", text: $address)
                }

                Button(action: addProperty) {
                    HStack {
                        Image(systemName: "plus.circle")
                        Text("Add Property")
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                Spacer()
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }

    private func addProperty() {
        guard let priceValue = Double(price), !title.isEmpty, !location.isEmpty else { return }

        let newProperty = Property(
            title: title,
            price: priceValue,
            location: location,
            coordinate: CLLocationCoordinate2D(latitude: 33.4242, longitude: -111.9281)
        )

        properties.append(newProperty)
        dismiss()
    }
}

struct LabeledField: View {
    var icon: String
    var placeholder: String
    @Binding var text: String
    var keyboard: UIKeyboardType = .default

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(.gray)
            TextField(placeholder, text: $text)
                .keyboardType(keyboard)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

#Preview {
    AddPropertyView(properties: .constant([]))
}
