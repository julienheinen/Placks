//
//  QrCodeGeneratorView.swift
//  Placks
//
//  Created by Julien Heinen on 15/05/2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QrCodeGeneratorView: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    let emailAddress = "julien@hyter.online"
    var body: some View {
        VStack {
            Text("Partage de Profil")
                .font(.largeTitle)
                .padding()
                Spacer()
            
            
            
            Image(uiImage: generateQRCode(from: "\(emailAddress)"))
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
                let url = URL(string: "mailto:\(self.emailAddress)")
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
}

#Preview {
    QrCodeGeneratorView()
}
