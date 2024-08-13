//
//  QrCodeGeneratorView.swift
//  Placks
//
//  Created by Julien Heinen on 15/05/2024.
//
import SwiftUI
import CodeScanner

struct QrCodeScannerView: View {
    @State private var isShowingScanner = true
    @State private var receiver_id = ""
    @State private var receiver_email = ""
    @Binding var showHamburger: Bool

    var body: some View {
            VStack {
                Text("Scanner un QR code")
                    .font(.headline)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.top, 60)

                if isShowingScanner {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "12345", completion: handleScan)
                } else {
                    NavigationLink(destination: SelectChat(receiver_Id: receiver_id, receiver_Email: receiver_email, showHamburger: $showHamburger)) {
                        Text("Continue")
                    }

                }
            }
            .onAppear {
                self.isShowingScanner = true
                showHamburger = false
            }
            .edgesIgnoringSafeArea(.all)


    }

    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            let detailsArray = result.string.components(separatedBy: "\n")
            guard detailsArray.count == 2 else { return }

            self.receiver_id = detailsArray[0]
            self.receiver_email = detailsArray[1]
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}

struct QrCodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QrCodeScannerView(showHamburger: Binding<Bool>.constant(false))
    }
}
