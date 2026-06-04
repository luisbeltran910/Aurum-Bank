//
//  LoginViewModel.swift
//  Aurum Bank
//
//  Created by Luis Beltran on 29/05/26.
//

import SwiftUI
import Combine
import LocalAuthentication

enum AuthState {
    case returningUser
    case newUser
    case authenticated
}

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var currentState: AuthState = .returningUser
    
    func login() async {
        guard !email.isEmpty, !password.isEmpty else {
//            self.errorMessage = "Please enter your email and password."
//            return
            await MainActor.run {
                self.errorMessage = "Please enter your email and password."
            }
            return
        }
        
        await MainActor.run {
            self.isLoading = true
            self.errorMessage = nil
        }
        
        print ("Sending server request to server for \(email)")
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        await MainActor.run {
            self.isLoading = false
            
            if email.lowercased() == "luis@aurum.com" && password == "password123" {
                print("Server returned HTTP 200: Success!")
                self.currentState = .authenticated
            } else {
                print("Server returned HTTP 401: Unauthorized")
                self.errorMessage = "Invalid email or password. Try Again."
            }
        }
    }
    
    func authenticateWithFaceID() {
        let context = LAContext()
        var error: NSError?
        
        // Smalll device compability check
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Login to your secure banking account."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {success, authenticateError in
                DispatchQueue.main.async {
                    if success {
                        print("Face ID Passed! Navigating to dashboard...")
                        self.currentState = .authenticated
                    } else {
                        self.errorMessage = authenticateError?.localizedDescription ?? "Biometric authentication failed."
                    }
                }
            }
        } else {
            self.errorMessage = "Face ID is not available on this device."
        }
    }
    
    func getGreetingMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 5..<12:
            return "Good Morning,"
        case 12..<19:
            return "Good Afternoon,"
        default:
            return "Good Evening,"
        }
    }
}
