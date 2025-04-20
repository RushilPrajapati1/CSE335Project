//
//  SignUpView.swift
//  CSE335Project
//
//  Created by Shubham Khalkho on 4/20/25.
//

import SwiftUI
import SwiftData

struct SignUpView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showError = false
    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 24) {
            Text("Create Account")
                .font(.largeTitle).bold()

            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if showError {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

            Button("Sign Up") {
                if password != confirmPassword {
                    errorMessage = "Passwords do not match"
                    showError = true
                } else {
                    let newUser = User(username: username, password: password)
                    context.insert(newUser)
                    dismiss()
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(12)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    SignUpView()
        .modelContainer(for: User.self)
}
