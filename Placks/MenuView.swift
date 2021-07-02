//
//  MenuView.swift
//  Placks
//
//  Created by Julien Heinen on 05/06/2021.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.red]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                //Tout en haut du menu
                MenuHeaderView()
                    .foregroundColor(.white)
                    .frame(height: 240)                //les logos
                
                ForEach(0..<5) { _ in
                    MenuOptionsView()
                        
                }
                
                Spacer()
                
            }
        }.navigationBarHidden(true)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
