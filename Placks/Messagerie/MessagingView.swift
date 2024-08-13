//
//  MessagingView.swift
//  Placks

import SwiftUI


struct MessagingView: View {
    @StateObject var messagesManager: MessagesManager
    @State var senderId: String
    @State var receiverId: String
    @State var emailReceiver: String
    @AppStorage("email") var storedEmail: String = ""
    @State var userName: String = ""
    @State var userImage: String = ""
        @Environment(\.presentationMode) var presentationMode

    init(senderId: String, receiverId: String, emailReceiver: String) {
        _messagesManager = StateObject(wrappedValue: MessagesManager(senderId: senderId, receiverId: receiverId))
        self._senderId = State(initialValue: senderId)
        self._receiverId = State(initialValue: receiverId)
        self._emailReceiver = State(initialValue: emailReceiver)
    }
    private func load_infos() {
    DatabaseManager.shared.loadData(storedEmail: emailReceiver, user_id: receiverId) { success, userData in
        if success, let userData = userData {
            self.userName = userData.prenom + " " + userData.nom
            self.userImage = userData.photo
        } else {
            self.userName = "Inconnu"
            self.userImage = "vache"
        }
    }
}
    var body: some View {
        VStack {
        TitleRow(imageName: userImage, name: userName)
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(messagesManager.messages, id: \.id) { message in
                        MessageBubble(message: message)
                    }
                }
                .padding(.top, 10)
                                    .background(.white)
                                    .cornerRadius(30, corners: [.topLeft, .topRight])
                                    .onChange(of: messagesManager.lastMessageId) { id in

                                        withAnimation {
                                            proxy.scrollTo(id, anchor: .bottom)
                                        }
                                    }
            }
            .background(Color("Peach"))
            MessageField()
                .environmentObject(messagesManager)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: QuitChatButton(action: quitChat)) //  custom "Quit Chat" button
        .onAppear {
            self.load_infos()
            DatabaseManager.shared.sendChattingMessage(userIdA: senderId, userIdB: receiverId, emailA: storedEmail) { success, errorMessage in
                if success {
                    // Handle success
                } else {
                    // Handle error
                }
            }
            
        }

    }

    private func quitChat() {
        // Show an alert to confirm quitting the chat
        let alert = UIAlertController(title: "Quit Chat", message: "Are you sure you want to quit the chat?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Quit", style: .destructive, handler: { _ in
            // Dismiss the current view and return to Accueil.swift
            self.presentationMode.wrappedValue.dismiss()
        }))

        // Present the alert
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
struct QuitChatButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Quiter le chat")
                .foregroundColor(.red)
        }
    }
}
struct MessagingView_Previews: PreviewProvider {
    static var previews: some View {
        MessagingView(senderId: "26", receiverId: "24", emailReceiver: "T")
    }
}

