//
//  MessagesManager.swift
//  Placks

import SwiftUI
import Foundation
import Combine

class MessagesManager: ObservableObject {
    @Published private(set) var messages: [Message] = []
    @Published private(set) var lastMessageId: String = ""
    let senderId: String
    let receiverId: String

    init(senderId: String, receiverId: String) {
        self.senderId = senderId
        self.receiverId = receiverId
        getMessages()
        startUpdatingMessages()
    }

    func sendMessage(text: String) {
        DatabaseManager.shared.sendMessage(senderId: senderId, receiverId: receiverId, message: text) { success, errorMessage in
            if !success {
                print("Error sending message: \(errorMessage)")
            }
        }
    }

    func getMessages() {
        DatabaseManager.shared.fetchMessages(senderId: senderId, receiverId: receiverId) { messages, errorMessage in
            if let messages = messages {
                self.messages = messages
                if let id = self.messages.last?.id {
                    self.lastMessageId = id                }
            } else {
                print("Error fetching messages: \(errorMessage)")
            }
        }
    }

    func startUpdatingMessages() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            self.getMessages()        }
    }
}
