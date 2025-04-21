//
//  LoginView.swift
//  CSE335Project
//
//  Created by Shubham Khalkho on 4/18/25.
//

import SwiftUI
import SwiftData
import SwiftUI

struct LoginView: View {
    @Query var users: [User]
    @State private var username = ""
    @State private var password = ""
    @State private var showingAlert = false
    @Binding var isLoggedIn: Bool
    @Namespace private var animation
    @State private var animateFields = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                VStack(spacing: 12) {
                    Image(systemName: "house.circle.fill")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.black)
                        .matchedGeometryEffect(id: "logo", in: animation)
                        .opacity(animateFields ? 1 : 0)
                        .offset(y: animateFields ? 0 : -20)
                        .animation(.easeOut(duration: 0.4), value: animateFields)

                    Text("Welcome Back")
                        .font(.largeTitle).bold()
                        .opacity(animateFields ? 1 : 0)
                        .animation(.easeOut.delay(0.1), value: animateFields)
                }
                .padding(.top, 60)

                VStack(spacing: 16) {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                        .opacity(animateFields ? 1 : 0)
                        .offset(x: animateFields ? 0 : -30)
                        .animation(.easeOut.delay(0.2), value: animateFields)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .opacity(animateFields ? 1 : 0)
                        .offset(x: animateFields ? 0 : -30)
                        .animation(.easeOut.delay(0.3), value: animateFields)
                }

                Button(action: {
                    if users.contains(where: { $0.username == username && $0.password == password }) {
                        withAnimation(.spring()) {
                            isLoggedIn = true
                        }
                    } else {
                        showingAlert = true
                    }
                }) {
                    HStack {
                        Image(systemName: "lock.open.fill")
                        Text("Log In")
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 4, y: 2)
                }
                .opacity(animateFields ? 1 : 0)
                .animation(.easeOut.delay(0.4), value: animateFields)
                .alert("Invalid credentials", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }

                NavigationLink(destination:
                    SignUpView()
                        .matchedGeometryEffect(id: "logo", in: animation)
                        .modelContainer(for: User.self)
                ) {
                    HStack(spacing: 4) {
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .bold()
                    }
                    .foregroundColor(.gray)
                    .opacity(animateFields ? 1 : 0)
                    .animation(.easeOut.delay(0.5), value: animateFields)
                }

                Spacer()
            }
            .padding()
            .background(Color(.systemGroupedBackground))
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                animateFields = true
            }
        }
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false))
        .modelContainer(for: User.self)
}
