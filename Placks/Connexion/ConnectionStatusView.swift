//
//  ConnectionStatusView.swift
//  Placks
//
//  Created by Julien Heinen on 13/08/2024.
//

import SwiftUI
import Network

struct ConnectionStatusView: View {
    @State private var isConnected = false
    @State private var showConnectionBanner = false

    var body: some View {
        ZStack {
            if showConnectionBanner {
                ConnectionBanner(isConnected: isConnected)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + (isConnected ? 5 : 10)) {
                            self.showConnectionBanner = false
                        }
                    }
            }
            
        }
        .position(CGPoint(x: UIScreen.main.bounds.width / 2, y: 30))
        .onAppear {
            checkInternetConnection()
        }
    }

func checkInternetConnection() {
    var previousConnectionStatus = false
    let monitor = NWPathMonitor()
    monitor.pathUpdateHandler = { path in
        DispatchQueue.main.async {
            let isConnectedNow = (path.status == .satisfied)
            if isConnectedNow != self.isConnected {
                self.isConnected = isConnectedNow
                if isConnectedNow && !previousConnectionStatus {
                    self.showConnectionBanner = true
                }
                previousConnectionStatus = isConnectedNow
            }
        }
    }
    let queue = DispatchQueue(label: "InternetMonitor")
    monitor.start(queue: queue)
}
}

struct ConnectionBanner: View {
    var isConnected: Bool

    var body: some View {
        VStack {
            Text(isConnected ? "Connexion rétablie" : "Connexion impossible")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 40) // Add this line

                .background(isConnected ? Color.green : Color.red)
        }
            
        .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
        .animation(.easeInOut(duration: 0.5))
    }
}

struct ConnectionStatusView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionStatusView()
    }
}

