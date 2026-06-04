//
//  Login.swift
//  Aurum Bank
//
//  Created by Luis Beltran on 12/05/26.
//

import Foundation

struct LoginRequest: Encodable {
    let username: String
    let password: String // will use only for transport for now
}

struct User: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let accountType: String // This will check if it's saving, checking or investment account.
}

struct AuthToken: Codable {
    let accessToken: String
    let expiresAt: String
}
