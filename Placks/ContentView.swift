//
//  ContentView.swift
//  Placks
//
//  Created by Julien Heinen on 17/05/2021.
//

import SwiftUI


struct ContentView: View {
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            MainView()
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        
           }
}

