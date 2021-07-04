//
//  ConnexionBambolView.swift
//  Placks
//
//  Created by Julien Heinen on 31/05/2021.
//

import SwiftUI

let LightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0)
let storedUsername = "Julien"
let storedPassword = "Barst"

struct ConnexionbamView: View {
    @State var username: String = ""
    @State var password: String = ""
    
    @State var authentificationDidFail: Bool = false
    @State var authrentificationDidSucceed: Bool = true
    var body: some View {
       
        ZStack{
            VStack{
                
                HelloText()
                UserImage()
                UsernameTextField(username: $username)
                PasswordSecureField(password: $password)
                NavigationLink(destination: ContentView()){
                    Text("accueil")
                        .font(.headline)
                        
                        .padding()
                }
                if authentificationDidFail {
                    Text("Informations incorrectes, réessayez")
                        .offset(y: -10)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    if self.username == storedUsername && self.password == storedPassword {
                    self.authrentificationDidSucceed = true
                        self.authentificationDidFail = false
                    } else {
                        self.authentificationDidFail = true
                        self.authrentificationDidSucceed = false
                    }
                    
                    
                }) {
                    LoginButtonContent()
                
                }
                
            }
            .padding()
            if authrentificationDidSucceed {
                Text("Connexion réussie")
                    .font(.headline)
                    .frame(width: 230, height: 50)
                    .background(Color.yellow)
                    .cornerRadius(20.0)
                    .animation(Animation.default)
            }
        
            
       
        }
        
    }
}
struct ConnexionbamView_Previews: PreviewProvider {
    static var previews: some View {
        ConnexionbamView()
    }
}

struct HelloText: View {
    var body: some View {
        Text("Connexion avec Bambol")
            .font(.title)
            .fontWeight(.semibold)
            .padding(.bottom, 15)
            .foregroundColor(.orange)
    }
}

struct UserImage: View {
    var body: some View {
        Image("userimage")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

struct LoginButtonContent: View {
    var body: some View {
        Text("Connexion")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.black)
            .cornerRadius(35.0)
    }
}

struct UsernameTextField: View {
    
    @Binding var username: String
    
    var body: some View {
        TextField(("Adresse e-mail"), text: $username)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct PasswordSecureField: View {
    @Binding var password: String
    
    var body: some View {
        SecureField("mot de passe", text: $password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}
