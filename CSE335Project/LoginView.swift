//
//  LoginView.swift
//  CSE335Project
//
//  Created by Shubham Khalkho on 4/18/25.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    @Query var users: [User]
    @State private var username = ""
    @State private var password = ""
    @State private var showingAlert = false
    @Binding var isLoggedIn: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()

                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textInputAutocapitalization(.never)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Log In") {
                    if users.contains(where: { $0.username == username && $0.password == password }) {
                        isLoggedIn = true
                    } else {
                        showingAlert = true
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
                .alert("Invalid credentials", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }

                Spacer()

                NavigationLink("Don't have an account? Sign Up", destination: SignUpView())
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false))
        .modelContainer(for: User.self)
}
