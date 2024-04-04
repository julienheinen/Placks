//
//  SideMenu.swift
//  Placks
//
//  Created by Julien Heinen on 27/06/2021.
//

import SwiftUI

struct SideMenu: View {
    @Binding var selectedTab: String
    @Binding var darkmode: Bool
    @Namespace var animation
    @Binding var showMenu: Bool
    @State private var showLogin = false
    @State private var isLoggedIn = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            // profile picture
            Image("userimage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .cornerRadius(10)
                .padding(.top, 85)

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

            // tab buttons
            VStack(alignment: .leading, spacing: 8) {
                TabButton(image: "house", title: "Accueil", selectedTab: $selectedTab, darkmode: $darkmode, showMenu: $showMenu, animation: animation)
                TabButton(image: "clock.arrow.circlepath", title: "Historique", selectedTab: $selectedTab, darkmode: $darkmode, showMenu: $showMenu, animation: animation)
                TabButton(image: "bell.badge", title: "Notifications", selectedTab: $selectedTab, darkmode: $darkmode, showMenu: $showMenu, animation: animation)
                TabButton(image: "gearshape.fill", title: "Paramètres", selectedTab: $selectedTab, darkmode: $darkmode, showMenu: $showMenu, animation: animation)
                TabButton(image: "questionmark.circle", title: "Aide", selectedTab: $selectedTab, darkmode: $darkmode, showMenu: $showMenu, animation: animation)
            }

            Spacer()

            // sign out button
            VStack(alignment: .leading, spacing: 6, content: {
                Toggle(isOn: $darkmode, label: {
                    HStack {
                        Text("Dark mode")
                            .foregroundColor(.white)
                        Image(systemName: darkmode ? "moon.zzz.fill" : "moon")
                            .foregroundColor(.white)
                    }
                })
                .toggleStyle(SwitchToggleStyle(tint: Color.gray))
                .frame(width: 170, alignment: .leading)

                TabButton(image: "rectangle.righthalf.inset.fill.arrow.right", title: "Se déconnecter", selectedTab: .constant(""), darkmode: $darkmode, showMenu: $showMenu, animation: animation)
                    .padding(.leading, -15)
            })
        })
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

        struct ImageView: View {
            var imageName: String
            var textColor: Color
            
            var body: some View {
                Text("Dark mode")
                    .foregroundColor(.white)
                Image(systemName: self.imageName)
                    .foregroundColor(.white)
            }
        }
    
    

