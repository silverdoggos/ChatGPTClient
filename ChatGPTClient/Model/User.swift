//
//  User.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 26.03.2023.
//
import Foundation

struct User: Identifiable, Decodable {
    let id = UUID()
    let username: String
    let fullname: String
    let email: String
    let profileImageUrl: String?
}

let MOCK_USERS = User(username: "test", fullname: "test test", email: " test@email.pp", profileImageUrl: nil)
