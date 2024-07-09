//
//  SideMenu.swift
//  Placks
//
//  Created by Julien Heinen on 27/06/2021.
//

import SwiftUI
import UIKit

struct SideMenu: View {
    @Binding var selectedTab: String
    @Binding var darkmode: Bool
    @Namespace var animation
    @Binding var showMenu: Bool
    @State private var showLogin = false
    @State private var isShowingProfileView = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("email") var storedEmail: String = ""
    @AppStorage("password") var storedPassword: String = ""
    @AppStorage("pp_profil") var pp_profil: String = "vache"
    var body: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            // profile picture
            Image(pp_profil)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .cornerRadius(10)
                .padding(.top, 85)

            VStack(alignment: .leading, spacing: 4) {
    Text("Julien Heinen")
        .font(.title)
        .fontWeight(.heavy)
        .foregroundColor(.white)

}
            // tab buttons
            VStack(alignment: .leading, spacing: 8) {
                TabButton(image: "house", title: "Accueil", selectedTab: $selectedTab, darkmode: $darkmode, showMenu: $showMenu, animation: animation)
                TabButton(image: "person", title: "Mon profil", selectedTab: $selectedTab, darkmode: $darkmode, showMenu: $showMenu, animation: animation)
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

                Button(action: {
                    // Show confirmation alert before logging out
                    showLogoutConfirmationAlert()
                }) {
                    HStack {
                        Image(systemName: "rectangle.righthalf.inset.fill.arrow.right")
                            .foregroundColor(.white)
                        Text("Se déconnecter")
                            .foregroundColor(.white)
                    }
                }
                .padding(.leading, -15)


            })
        })
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        
    }
    func showLogoutConfirmationAlert() {
        let alert = UIAlertController(title: "Déconnexion", message: "Êtes-vous sûr de vouloir vous déconnecter ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Déconnexion", style: .destructive, handler: { _ in
            // Remove stored email and password
            self.$storedEmail.wrappedValue = ""
            self.$storedPassword.wrappedValue = ""
            UserDefaults.standard.removeObject(forKey: storedPassword)
            self.isLoggedIn = false
            restartApplication()
        
            
        }))
        
        // Present the alert
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    func restartApplication() {
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIApplication.shared.perform(#selector(NSXPCConnection.resume))
        }
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
    
    

