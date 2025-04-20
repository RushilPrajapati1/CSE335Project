//
//  LoginView.swift
//  CSE335Project
//
//  Created by Shubham Khalkho on 4/18/25.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    @Environment(\.modelContext) private var context
    @Query private var users: [User]

    @State private var isCreatingAccount = false
    @State private var username = ""
    @State private var password = ""
    @State private var statusMessage = ""
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            HomeView(isLoggedIn: $isLoggedIn)
                .environmentObject(MapModel())
                .environmentObject(SearchModel())
        } else {
            loginScreen
        }
    }

    var loginScreen: some View {
        VStack(spacing: 20) {
            Text(isCreatingAccount ? "Create Account" : "Login")
                .font(.largeTitle).bold()

            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: handleAction) {
                Text(isCreatingAccount ? "Sign Up" : "Log In")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Text(statusMessage)
                .foregroundColor(.red)

            Button(action: {
                isCreatingAccount.toggle()
                statusMessage = ""
            }) {
                Text(isCreatingAccount ? "Already have an account? Log In" : "Don't have an account? Sign Up")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }.padding()
    }

    private func handleAction() {
        if isCreatingAccount {
            if users.contains(where: { $0.username == username }) {
                statusMessage = "Username already exists"
                return
            }
            let newUser = User(username: username, password: password)
            context.insert(newUser)
            do {
                try context.save()
                // workaround for SwiftData not updating @Query immediately
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    statusMessage = "Account created! Please log in."
                    username = ""
                    password = ""
                    isCreatingAccount = false
                }
            } catch {
                statusMessage = "Error saving account."
            }
        } else {
            if users.contains(where: { $0.username == username && $0.password == password }) {
                isLoggedIn = true
            } else {
                statusMessage = "Invalid credentials"
            }
        }
    }
}
