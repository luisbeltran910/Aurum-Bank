//
//  DashboardView.swift
//  Aurum Bank
//
//  Created by Luis Beltran on 04/06/26.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 24) {
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(viewModel.getGreetingMessage())
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Luis Angel")
                            .font(.title2)
                            .bold()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // TODO: Future profile stuff
                    }) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
                
                // Account Balance
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Aurum Checking")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.8))
                        Spacer()
                        Image(systemName: "waveform.path.ecg")
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    Text("12,450.80")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    HStack {
                        Text("**** 4829")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.6))
                        Spacer()
                        Text("MXN")
                            .font(.caption)
                            .bold()
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(4)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(LinearGradient(colors: [Color.blue, Color(red: 0.1, green: 0.3, blue: 0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(16)
                .shadow(color: Color.blue.opacity(0.3), radius: 8, x: 0, y: 4)
                .padding(.horizontal)
                
                // Quick Actions for bank options
                HStack(spacing: 20) {
                    QuickActionButton(icon: "arrow.up.right.circle.fill", title: "Transfer")
                    QuickActionButton(icon: "doc.text.fill", title: "Pay Bills")
                    QuickActionButton(icon: "qrcode", title: "Scan QR")
                    QuickActionButton(icon: "ellipsis.circle.fill", title: "More")
                }
                .padding(.horizontal)
                
                // Movements / Transactions
                VStack(alignment: .leading, spacing: 12) {
                    Text("Recent Activity")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    VStack(spacing: 0) {
                        MovementsRow(title: "Starbucks", date: "Today", amount: "-128.00", isIncome: false)
                        Divider().padding(.horizontal)
                        MovementsRow(title: "Payroll Deposit", date: "Yesterday", amount: "+17,000.00", isIncome: true)
                        Divider().padding(.horizontal)
                        MovementsRow(title: "Netflix Subscription", date: "June 2", amount: "-339.00", isIncome: false)
                        Divider().padding(.horizontal)
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    .padding(.horizontal)
                }
                
                // Sign Out
                Button(action: {
                    viewModel.currentState = .returningUser
                }) {
                    Text("Sign Out")
                        .font(.headline)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Capsule().stroke(Color.red, lineWidth: 1.5))
                }
                .padding(.horizontal, 30)
                .padding(.top)
            }
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}

// QuickActionButton and MovementRow
struct QuickActionButton: View {
    let icon: String
    let title: String
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(.blue)
                    .frame(width: 60, height: 60)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Circle())
                
                Text(title)
                    .font(.caption)
                    .bold()
                    .foregroundColor(.primary)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct MovementsRow: View {
    let title: String
    let date: String
    let amount: String
    let isIncome: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                    .bold()
                Text(date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(amount)
                .font(.body)
                .bold()
                .foregroundColor(isIncome ? .green : .primary)
        }
        .padding()
    }
}
