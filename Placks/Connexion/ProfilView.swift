//
//  ProfilView.swift
//  Placks
//
//  Created by Julien Heinen on 15/05/2024.
//

import SwiftUI

struct ProfilView: View {
    //Informations
    
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("birthDate") var birthDate: String = ""
    @AppStorage("country") var country: String = ""
    @AppStorage("region") var region: String = ""
    @AppStorage("ls") var ls: String = ""
    @State private var subscription = "Premium"
    @AppStorage("email") var storedEmail: String = ""
    @State private var skillLevel = "Avancé"
    @State private var signsLearned = "500"
    @AppStorage("pp_profil") var pp_profil: String = ""
    
    var body: some View {
        VStack {
            
            Text("Mon Profil")
                .font(.title)
                .padding(.bottom, 10)
                .padding()
            

            Menu {
                Button(action: {
                    pp_profil = "vache"
                }) {
                    Label("Vache", systemImage: "vache")
                }
                Button(action: {
                    pp_profil = "chat"
                }) {
                    Label("Chat", systemImage: "chat")
                }
                Button(action: {
                    pp_profil = "hibou"
                }) {
                    Label("Hiboux", systemImage: "hibou")
                }
                Button(action: {
                    pp_profil = "cheval"
                }) {
                    Label("Cheval", systemImage: "cheval")
                }
                Button(action: {
                    pp_profil = "paresseux"
                }) {
                    Label("Paresseux", systemImage: "paresseux")
                }
            } label: {
                Image(pp_profil)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 170, height: 170)
                    .cornerRadius(300)
                    .padding(.top, 5)
                    .padding()
            }
            
Text($lastName.wrappedValue)
    .cornerRadius(8)
    .padding(.horizontal)

Text($firstName.wrappedValue)
    .cornerRadius(8)
    .padding(.horizontal)

Text($storedEmail.wrappedValue)
    .cornerRadius(8)
    .padding(.horizontal)

Text($birthDate.wrappedValue)
    .cornerRadius(8)
    .padding(.horizontal)

Text($ls.wrappedValue)
    .cornerRadius(8)
    .padding(.horizontal)

Text($country.wrappedValue)
    .cornerRadius(8)
    .padding(.horizontal)

            Text($region.wrappedValue)
                .cornerRadius(8)
                .padding(.horizontal)
            Spacer()
        }
    }
}

#Preview {
    ProfilView()
}
