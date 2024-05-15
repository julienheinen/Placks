//
//  ContentView.swift
//  Placks
//
//  Created by Julien Heinen on 17/05/2021.
//

import SwiftUI


struct ContentView: View {
    @State private var isLoggedIn = false
    var test=0
    var body: some View {
        
        switch test {
        case 0:
            MainView()
        case 1:
            LoginView()
        case 3:
            CameraView()
            
            //if isLoggedIn {
            //  MainView()
            //} else {
            //  LoginView()
            //}
        default:
            MainView()
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        
        
        static var previews: some View {
            ContentView()
                .preferredColorScheme(.light)
            
        }
    }
    
}
