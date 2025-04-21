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
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundColor(.black)
                Text("Search By Location")
                    .font(.title2)
                    .bold()
            }
            .padding(.top)
            .transition(.opacity.combined(with: .move(edge: .top)))
            .animation(.easeInOut(duration: 0.4), value: city)

            VStack(alignment: .leading, spacing: 8) {
                Text("Enter City")
                    .font(.caption)
                    .foregroundColor(.gray)

                HStack {
                    Image(systemName: "building.2.fill")
                        .foregroundColor(.gray)
                    TextField("City", text: $city)
                        .textInputAutocapitalization(.never)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
            .transition(.move(edge: .leading).combined(with: .opacity))
            .animation(.easeIn(duration: 0.4), value: city)

            VStack(alignment: .leading, spacing: 8) {
                Text("Maximum Price: $\(Int(price))")
                    .font(.subheadline)
                Slider(value: $price, in: 100...10000, step: 100)
            }
            .transition(.scale.combined(with: .opacity))
            .animation(.easeIn(duration: 0.4), value: price)

            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    navigate = true
                }
            }) {
                HStack {
                    Image(systemName: "arrow.right.circle.fill")
                    Text("Next")
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(radius: 4)
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .navigationDestination(isPresented: $navigate) {
            SearchFilterStepTwo(city: city, price: price)
                .transition(.move(edge: .trailing).combined(with: .opacity))
        }
    }
}

#Preview {
    NavigationStack {
        SearchFilterStepOne()
    }
}
