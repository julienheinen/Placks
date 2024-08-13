//
//  QrCodeGeneratorView.swift
//  Placks
//
//  Created by Julien Heinen on 25/07/2024.
//
import SwiftUI

struct SelectChat: View {
    let receiver_Id: String
    let receiver_Email: String
    @AppStorage("user_id") var user_id: String = ""
    @Binding var showHamburger: Bool


    var body: some View {
        VStack {
            Text("Choose an action")
                .font(.title)
                .padding()
            Text(user_id)
            Text(receiver_Id)
            Text(receiver_Email)
            NavigationLink(destination: MessagingView(senderId: user_id, receiverId: receiver_Id, emailReceiver: receiver_Email)) {
                Text("Use Messaging")
            }
                .navigationBarBackButtonHidden(true) // Hide the default back button

            NavigationLink(destination: CameraView(showHamburger: $showHamburger)) {
                Text("Use Gesture Recognition")
            }
        }
        

        .onAppear {
            showHamburger = false
            DatabaseManager.shared.sendWaitingMessage(userIdA: user_id, userIdB: receiver_Id) { success, errorMessage in
                if success {
                    // Handle success
                } else {
                    // Handle error
                }
            }
        }

    }
    
}


#Preview {
    SelectChat(receiver_Id: "23", receiver_Email: "test@example.com", showHamburger: .constant(false))
}
