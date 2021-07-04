//
//  SideMenu.swift
//  Placks
//
//  Created by Julien Heinen on 27/06/2021.
//

import SwiftUI

struct SideMenu: View {
    @Binding var selectedTab: String
    @Namespace var animation
    var body: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            
            //profile Pic
            Image("userimage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .cornerRadius(10)
            //padding top for Top Close Button...
                .padding(.top,50)
            
            VStack(alignment: .leading, spacing: 4, content: {
                
                Text("Julien Heinen")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Button(action: {}, label: {
                    Text("Voir le profil")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .opacity(0.7)
                })
            })
            // tab Buttons...
            VStack(alignment: .leading,spacing: 8){
                
                TabButton(image: "house", title: "Accueil", selectedTab: $selectedTab, animation: animation)
                
                TabButton(image: "clock.arrow.circlepath", title: "Historique", selectedTab: $selectedTab, animation: animation)
                
                TabButton(image: "bell.badge", title: "Notifications", selectedTab: $selectedTab, animation: animation)
                
                TabButton(image: "gearshape.fill", title: "Paramètres", selectedTab: $selectedTab, animation: animation)
                
                TabButton(image: "questionmark.circle", title: "Aide", selectedTab: $selectedTab, animation: animation)
            }
            .padding(.leading,-15)
            .padding(.top,50)
            
            Spacer()
            
            //Sign Out Button...
            VStack(alignment: .leading, spacing: 6, content: {
                    TabButton(image: "rectangle.righthalf.inset.fill.arrow.right", title: "Se déconnecter", selectedTab: .constant(""), animation: animation)
                        .padding(.leading,-15)
                    
                    Text("Version 1.0.0 de l'application")
                        .font(.caption)
                        .fontWeight(.semibold)
            })
            
        })
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
