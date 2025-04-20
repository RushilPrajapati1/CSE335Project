//
//  SearchFilterStepOne.swift
//  CSE335Project
//
//  Created by Shubham Khalkho on 4/20/25.
//

import SwiftUI

struct SearchFilterStepOne: View {
    @State private var city: String = ""
    @State private var price: Double = 1000
    @State private var navigate = false

    var body: some View {
        VStack(spacing: 24) {
            Text("Search By Location")
                .font(.title)
                .bold()

            TextField("Enter city", text: $city)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)

            VStack(alignment: .leading) {
                Text("Maximum Price: $\(Int(price))")
                Slider(value: $price, in: 100...10000, step: 100)
            }

            Button(action: {
                navigate = true
            }) {
                Text("Next")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        .padding()
        .navigationDestination(isPresented: $navigate) {
            SearchFilterStepTwo(city: city, price: price)
        }
    }
}

#Preview {
    NavigationStack {
        SearchFilterStepOne()
    }
}
