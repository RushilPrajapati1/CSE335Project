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
    @State private var showSuccess = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Create Account")
                    .font(.largeTitle).bold()

                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textInputAutocapitalization(.never)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }

                Button("Sign Up") {
                    guard !username.isEmpty, !password.isEmpty else {
                        errorMessage = "Please fill all fields"
                        showError = true
                        return
                    }

                    guard password == confirmPassword else {
                        errorMessage = "Passwords do not match"
                        showError = true
                        return
                    }

                    let newUser = User(username: username, password: password)
                    context.insert(newUser)

                    do {
                        try context.save()
                        showSuccess = true
                    } catch {
                        errorMessage = "Failed to save user: \(error.localizedDescription)"
                        showError = true
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(12)
                .alert(isPresented: $showSuccess) {
                    Alert(
                        title: Text("Account Created"),
                        message: Text("You can now log in."),
                        dismissButton: .default(Text("OK")) {
                            dismiss()
                        }
                    )
                }

                Spacer()
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .onTapGesture {
            hideKeyboard()
        }
    }

    private func hideKeyboard() {
#if canImport(UIKit)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
#endif
    }
}
