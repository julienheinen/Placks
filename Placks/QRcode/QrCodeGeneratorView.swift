//
//  QrCodeGeneratorView.swift
//  Placks
//
//  Created by Julien Heinen on 15/05/2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QrCodeGeneratorView: View {
    @State private var discussionStatus: String = ""
    @State private var userIdA: String?
    @State private var emailA: String?
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    @AppStorage("user_id") var user_id: String = ""
    @AppStorage("email") var storedEmail: String = ""
    @State private var navigateToMessagingView = false
    @Binding var showHamburger: Bool 

    
    var body: some View {
        VStack {
            Text("Partage de Profil")
                .font(.largeTitle)
                .padding()
                Spacer()
            if discussionStatus == "waiting" {
                HStack {
                    Text("Votre interlocuteur se connecte")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    VStack(spacing: 4) {
                        ForEach(0..<3) { index in
                            Circle()
                                .fill(Color.white)
                                .frame(width: 6, height: 6)
                                .offset(y: index == 1 ? -5 : 0)
                                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(Double(index) * 0.2))
                        }
                    }
                }
                .padding(.horizontal)
                .frame(height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.red)
                )
            }else if discussionStatus == "chatting" {
                // Display green square
                Button(action: {
                    self.navigateToMessagingView = true
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.green)
                        .frame(width: 200, height: 50)
                        .overlay(
                            HStack {
                                Text("Commencer la conversation")
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                Image(systemName: "bubble.left.and.text.bubble.right.fill")
                                    .foregroundColor(.white)
                            }
                        )
                        .padding()
                }
            }
            
            Image(uiImage: generateQRCode(from: "\(user_id)\n\(storedEmail)"))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Spacer()
            
            Button(action: {
                // Action de scan
                // Code pour scanner le QR code
            }) {
                HStack {
                    Image(systemName: "qrcode.viewfinder")
                        .foregroundColor(.white)
                    Text("Scanner")
                        .foregroundColor(.white)
                        .font(.headline)
                        .fontWeight(.bold)
                }
            }
            .frame(width: 500)
            .frame(maxWidth: 300)
            .frame(alignment: .center)
            .padding()
            .background(Color.green) 
            .cornerRadius(15)
            Button(action: {
                // Action de partage
                let url = URL(string: self.user_id)
                let activityViewController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
                UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
            }) {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.white)
                    Text("Partager")
                        .foregroundColor(.white)
                        .font(.headline)
                        .fontWeight(.bold)
                }
            }
            .frame(width: 500)
            .frame(maxWidth: 300)
            .frame(alignment: .center)
            .padding()
            .background(Color.blue)
            .cornerRadius(15)
        }
        .background(
            NavigationLink(destination: MessagingView(senderId: user_id, receiverId: userIdA ?? "", emailReceiver: emailA ?? "" /*showHamburger: $showHamburger*/), isActive: $navigateToMessagingView) {
            }
        )
        .onAppear {
            // Check discussion status when the view appears
            startUpdatingDiscussionStatus()
            showHamburger = false
        }

    
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    private func startUpdatingDiscussionStatus() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            self.checkDiscussionStatus()
            print("Updating discussion status")
        }
    }

    private func checkDiscussionStatus() {
        DatabaseManager.shared.checkDiscussionStatus(userIdB: user_id) { status, userIdA, emailA, errorMessage in
            self.discussionStatus = status
            self.userIdA = userIdA
            self.emailA = emailA
        }
    }
}

#Preview {
    QrCodeGeneratorView(showHamburger: .constant(false))}
