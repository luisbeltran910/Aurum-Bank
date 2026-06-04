//
//  LoginView.swift
//  Aurum Bank
//
//  Created by Luis Beltran on 10/05/26.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        if viewModel.currentState == .authenticated {
            DashboardView(viewModel: viewModel)
        } else {
            VStack {
                HStack {
                    Text("AURUM BANK")
                        .font(.headline)
                        .foregroundColor(Color.blue)
                        .bold()
                    
                    Spacer()
                    Image(systemName: "line.3.horizontal")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                .padding()
                
                Spacer()
                
                // Returning user content
                if viewModel.currentState == .returningUser {
                    
                    // Returning user interface
                    VStack(spacing: 8) {
                        Text(viewModel.getGreetingMessage())
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        Text("Luis Angel")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.secondary)
                        
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.authenticateWithFaceID()
                    }) {
                        Image(systemName: "faceid")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // New user or logged out
                        viewModel.currentState = .newUser
                    }) {
                        Text("Login with password")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                Capsule()
                                    .stroke(Color.blue, lineWidth: 1.5))
                    }
                    .padding(.horizontal, 30)
                    
                } else {
                    // New user interface
                    VStack(spacing: 20) {
                        Text("Welcome to Aurum Bank")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.blue)
                        
                        if let errorMessage = viewModel.errorMessage {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.red)
                                Text(errorMessage)
                                    .font(.subheadline)
                                    .foregroundColor(.red)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                            }
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(8)
                            .transition(.move(edge: .top).combined(with: .opacity))
                        }
                        
                        TextField("Email", text: $viewModel.email)
                            .textFieldStyle(.roundedBorder)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .disabled(viewModel.isLoading)
                        
                        SecureField("Password", text: $viewModel.password)
                            .textFieldStyle(.roundedBorder)
                            .disabled(viewModel.isLoading)
                        
                        Button(action: {
                            Task {
                                await viewModel.login()
                            }
                        }) {
                            if viewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue.opacity(0.6))
                                    .cornerRadius(10)
                            } else {
                                
                                Text("Sign In")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                        }
                        .disabled(viewModel.isLoading)
                        
                        Button(action: {
                            viewModel.currentState = .returningUser
                        }) {
                            Text("Cancel")
                                .foregroundColor(.gray)
                        }
                        .disabled(viewModel.isLoading)
                    }
                    
                    .padding(.horizontal, 30)
                    .animation(.default, value: viewModel.errorMessage)
                }
                
                Spacer()
                
            }
            .padding(.bottom)
        }
        
    }
}

#Preview {
    LoginView()
}
