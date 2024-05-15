//
//  LoginView.swift
//  Placks
//
//  Created by Julien Heinen on 13/05/2024.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @State private var isRegisterViewPresented = false
    @State private var email = ""
    @State private var password = ""
    @State private var showError = false
    @State private var isLoggedIn = false

    var body: some View {
        VStack {
            Spacer()
            Text("Sign In")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
            TextField("Adresse e-mail", text: $email)
                .padding()
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("mot de passe", text: $password)
                .padding()
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            if showError {
                Text("Vérifiez vos informations de connexion")
                    .offset(y: -10)
                    .foregroundColor(.red)
            }
            Button(action: {
    // Ajoutez votre logique d'authentification ici
    login()
}) {
    Text("CONNEXION")
        .font(.headline)
        .foregroundColor(.white)
        .padding()
        .frame(width: 220, height: 60)
        .background(Color.green)
        .cornerRadius(15.0)
}
.padding(.top, 20)

Button(action: {
    isRegisterViewPresented = true
}) {
    Text("Créer un compte")
        .font(.headline)
        .foregroundColor(.blue)
}
.padding(.top, 20)
Spacer()
        }
        .padding()
        .sheet(isPresented: $isRegisterViewPresented) {
            RegisterView()
        }
    }

    func login() {
        guard let url = URL(string: "https://vegetalsearch.alwaysdata.net/API/login.php") else {
            print("Invalid URL")
            return
        }

        let loginDetails = ["email": email, "password": password]

        guard let loginData = try? JSONEncoder().encode(loginDetails) else {
            print("Failed to encode login details")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = loginData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.isLoggedIn = decodedResponse.success
                        self.showError = !self.isLoggedIn
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct LoginResponse: Codable {
    var success: Bool
}
    
    
    
struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showError = false
    @State private var isRegistered = false

    var body: some View {
        VStack {
            Spacer()
            Text("Inscription")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
            TextField("Adresse e-mail", text: $email)
                .padding()
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("Mot de passe", text: $password)
                .padding()
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            if showError {
                Text("Erreur lors de l'inscription")
                    .offset(y: -10)
                    .foregroundColor(.red)
            }
            Button(action: {
                // Ajoutez votre logique d'inscription ici
                register()
            }) {
                Text("INSCRIPTION")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
            .padding(.top, 20)
            Spacer()
        }
        .padding()
    }

    func register() {
        guard let url = URL(string: "https://vegetalsearch.alwaysdata.net/API/register.php") else {
            print("Invalid URL")
            return
        }

        let registerDetails = ["email": email, "password": password]

        guard let registerData = try? JSONEncoder().encode(registerDetails) else {
            print("Failed to encode register details")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = registerData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(RegisterResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.isRegistered = decodedResponse.success
                        self.showError = !self.isRegistered
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct RegisterResponse: Codable {
    var success: Bool
}
    
    struct UsernameTextField: View {
        @Binding var username: String
        var body: some View {
            return TextField("Adresse e-mail", text: $username)
                .padding()
                .cornerRadius(5.0)
                .padding(.bottom, 20)
        }
    }
    
    struct LoginButtonContent: View {
        var body: some View {
            Text("CONNEXION")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.green)
                .cornerRadius(15.0)
        }
    }
    
    struct PasswordSecureField: View {
        
        @Binding var password: String
        var body: some View {
            SecureField("mot de passe", text: $password)
                .padding()
                .cornerRadius(5.0)
                .padding(.bottom, 20)
        }
    }
    
    
    
    

