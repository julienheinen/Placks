//
//  Message.swift
//  Placks


import Foundation

struct Message: Codable {
    let id: String
    let text: String
    let received: Bool
    let timestamp: Date
}

struct APIMessage: Codable, Identifiable {
    let id: Int
    let senderId: Int
    let receiverId: Int
    let message: String
    let timestamp: String
}


