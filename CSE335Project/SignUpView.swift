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
    @State private var animateForm = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 10) {
                    Image(systemName: "person.crop.circle.badge.plus")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.black)
                        .opacity(animateForm ? 1 : 0)
                        .offset(y: animateForm ? 0 : -20)
                        .animation(.easeOut(duration: 0.4), value: animateForm)

                    Text("Create Account")
                        .font(.largeTitle).bold()
                        .opacity(animateForm ? 1 : 0)
                        .animation(.easeOut.delay(0.1), value: animateForm)
                }
                .padding(.top, 40)

                Group {
                    AnimatedTextField(icon: "person", placeholder: "Username", text: $username, delay: 0.2)
                    AnimatedTextField(icon: "lock", placeholder: "Password", text: $password, isSecure: true, delay: 0.3)
                    AnimatedTextField(icon: "lock.rotation", placeholder: "Confirm Password", text: $confirmPassword, isSecure: true, delay: 0.4)
                }

                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .transition(.opacity)
                }

                Button("Sign Up") {
                    if password != confirmPassword {
                        errorMessage = "Passwords do not match"
                        showError = true
                    } else {
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
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(12)
                .opacity(animateForm ? 1 : 0)
                .animation(.easeOut.delay(0.5), value: animateForm)
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
        .onAppear {
            animateForm = true
        }
    }
}

struct AnimatedTextField: View {
    var icon: String
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var delay: Double = 0

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(.gray)
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .opacity(1)
        .transition(.move(edge: .trailing).combined(with: .opacity))
        .animation(.easeOut.delay(delay), value: text)
    }
}

#Preview {
    SignUpView()
        .modelContainer(for: User.self)
}
