//
//  QrCodeScannerView.swift
//  Placks
//
//  Created by Julien Heinen on 15/05/2024.
//

import SwiftUI
import CodeScanner

struct QrCodeScannerView: View {
    @State private var isShowingScanner = true

    
    var body: some View {
        VStack {
    Text("Scanner un QR code")
    .font(.headline)
    .padding()
    .background(Color.gray.opacity(0.8))
    .cornerRadius(10)
    .padding(.top, 60)
            if isShowingScanner {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
            }
        }
        .onAppear {
            self.isShowingScanner = true
        }
        .edgesIgnoringSafeArea(.all) // Add this modifier to ignore the safe area
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            let detailsArray = result.string.components(separatedBy: "\n")
            guard detailsArray.count == 2 else { return }
            
            let person = QrCodeScannerView()
            
            // modelContext.insert(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}


#Preview {
    QrCodeScannerView()
}
