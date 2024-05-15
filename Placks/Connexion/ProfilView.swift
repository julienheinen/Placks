//
//  ProfilView.swift
//  Placks
//
//  Created by Julien Heinen on 15/05/2024.
//

import SwiftUI

struct ProfilView: View {
    @State private var name = "Julien"
    @State private var surname = "Heinen"
    @State private var age = "30 ans"
    @State private var signLanguage = "LS Française"
    @State private var subscription = "Premium"
    @State private var email = "julien@hyter.online"
    @State private var skillLevel = "Avancé"
    @State private var signsLearned = "500"
    
    var body: some View {
        VStack {
            
            Text("Mon Profil")
                .font(.title)
                .padding(.bottom, 10)
                .padding()
            Image("userimage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170, height: 170)
                .cornerRadius(10)
                .padding(.top, 5)
                .padding()
            
            TextField("Nom", text: $name)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            
            TextField("Prénom", text: $surname)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)

            TextField("Email", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            TextField("Age", text: $age)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)

            TextField("Langue des signes", text: $signLanguage)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            
            Spacer()
        }
    }
}

#Preview {
    ProfilView()
}
