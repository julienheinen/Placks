//
//  LoginView.swift
//  Placks
//
//  Created by Julien Heinen on 10/05/2024.
//
import SwiftUI
import AuthenticationServices
struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var isRegistered: Bool = true
    @AppStorage("email") var storedEmail: String = ""
    @AppStorage("password") var storedPassword: String = ""
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var darkmode = false
    @AppStorage("user_id") var user_id: String = ""

    var body: some View {
        ZStack {
            if self.isLoggedIn {
                ContentView()
            } else {
                if self.isRegistered {
                    LoginViewContent
                } else {
                    RegisterView(isRegistered: $isRegistered)
                }
            }
        }
    }

    var LoginViewContent: some View {
        ZStack {
            ConnectionStatusView()
            //Bg
            Image("BG_LoginView")
                .resizable()
                .overlay(
                    Rectangle()
                        .foregroundColor(Color.black.opacity(0.65))
                )
                .ignoresSafeArea(.all)

            VStack {
                //Logo
                Image("AppIcon-Preview")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .padding(.top, 45)
                Spacer()
                // Form
                VStack(spacing: 15) {
                    VStack(alignment: .center, spacing: 30) {
                        Text("Connexion")
                            .font(Font.custom("OpenSans-Bold", size: 24))
                            .foregroundColor(Color.white)
                            .padding(.bottom, 30)
                            .padding(.top, 30)
                        CustomTextfield(placeholder: "Username",
                                        fontName: "OpenSans-Regular",
                                        fontSize: 18,
                                        fontColor: Color.white.opacity(1),
                                        text: $storedEmail)
                        CustomSecureField(placeholder: "Password",
                                          fontName: "OpenSans-Regular",
                                          fontSize: 18,
                                          fontColor: Color.white.opacity(0.3),
                                          text: $storedPassword)
                    }
                    HStack {
                        Button(action: {
                            // nuveau password à ajouter
                        }) {
                            Text("Request new password.")
                                .font(Font.custom("OpenSans-Regular", size: 14))
                                .foregroundColor(Color.white.opacity(0.65))
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal, 35)

                //Login Button
                Button(action: {
                    DatabaseManager.shared.loginUser(email: storedEmail, password: storedPassword) { success, message, userId, isComplete in
                        if success, let userId = userId {
                            self.user_id = userId
                            self.isLoggedIn = true
                            let defaults = UserDefaults.standard
                            defaults.set(true, forKey: "isLoggedIn")
                            defaults.set(true, forKey: "isComplete")
                            print(isLoggedIn)
                        } else {
                            self.errorMessage = message
                            self.showError = true
                        }
                    }
                }) {
                    Text("login".uppercased())
                        .font(Font.custom("OpenSans-Bold", size: 14))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 35)
                .padding(.top, 30)
                Spacer()
                //SignUp
                VStack(spacing: 15) {
                    
                    Text("Need an account?")
                        .font(Font.custom("OpenSans-Bold", size: 14))
                        .foregroundColor(Color.white.opacity(0.5))
                    Button(action: {
                        self.isRegistered = false
                    }) {
                        Text("sign up".uppercased())
                            .font(Font.custom("OpenSans-Bold", size: 14))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.white.opacity(0.15))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 90)
                .padding(.bottom, 30)
                SignInWithAppleButton(
                    onRequest: { request in
                        request.requestedScopes = [.fullName, .email]
                    },
                    onCompletion: { result in
                        switch result {
                        case .success(let authResults):

                            if let credential = authResults.credential as? ASAuthorizationAppleIDCredential,
                               let email = credential.email {
        
                                DatabaseManager.shared.loginUser(email: email, password: "placeholder_password") { success, message, userId, isComplete in
                                    if success, let userId = userId {
                                        UserDefaults.standard.set(email, forKey: "email")
                                        UserDefaults.standard.set(userId, forKey: "user_id")
                                       
                                    } else {
                                        // login fail message
                                        print(message)
                                    }
                                }
                            }
                        case .failure(let error):
                            // Handle authentication failure
                            print(error.localizedDescription)
                        }
                    }
                )
                .frame(width: 280, height: 45)
                .padding(.top, 30)
            }
            if showError {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
    }
}

struct RegisterView: View {
    @Binding var isRegistered: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showError = false
    @State private var errorMessage = ""

    var body: some View {
        ZStack {
            //fond écran
            Image("BG_LoginView")
                .resizable()
                .overlay(
                    Rectangle()
                        .foregroundColor(Color.black.opacity(0.65))
                )
                .ignoresSafeArea(.all)

            VStack {
                //Logo
                Image("Second-logo")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .padding(.top, 45)
                Spacer()

                VStack(spacing: 15) {
                    VStack(alignment: .center, spacing: 30) {
                        Text("Créer mon compte")
                            .font(Font.custom("OpenSans-Bold", size: 24))
                            .foregroundColor(Color.white)
                            .padding(.bottom, 30)
                            .padding(.top, 30)
                        CustomTextfield(placeholder: "Email",
                                        fontName: "OpenSans-Regular",
                                        fontSize: 18,
                                        fontColor: Color.white.opacity(0.3),
                                        text: $email)
                        CustomSecureField(placeholder: "Password",
                                          fontName: "OpenSans-Regular",
                                          fontSize: 18,
                                          fontColor: Color.white.opacity(0.3),
                                          text: $password)
                        CustomSecureField(placeholder: "Confirm Password",
                                          fontName: "OpenSans-Regular",
                                          fontSize: 18,
                                          fontColor: Color.white.opacity(0.3),
                                          text: $confirmPassword)
                    }
                }
                .padding(.horizontal, 35)


                Button(action: {
                    if password == confirmPassword {
                        DatabaseManager.shared.registerUser(email: email, password: password) { success, message in
                            if success {
                                self.isRegistered = true
                            } else {
                                self.errorMessage = message
                                self.showError = true
                            }
                        }
                    } else {
                        self.errorMessage = "Passwords do not match"
                        self.showError = true
                    }
                }) {
                    Text("register".uppercased())
                        .font(Font.custom("OpenSans-Bold", size: 14))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 35)
                .padding(.top, 30)
                Spacer()

                VStack(spacing: 15) {
                    Text("Already have an account?")
                        .font(Font.custom("OpenSans-Bold", size: 14))
                        .foregroundColor(Color.white.opacity(0.5))
                    Button(action: {
                        self.isRegistered = true
                    }) {
                        Text("login".uppercased())
                            .font(Font.custom("OpenSans-Bold", size: 14))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.white.opacity(0.15))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 90)
                .padding(.bottom, 30)
            }
            if showError {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
    }
}



struct CustomTextfield: View {
    var placeholder: String
    var fontName: String
    var fontSize: CGFloat
    var fontColor: Color
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
                    .font(Font.custom(fontName, size: fontSize))
                    .foregroundColor(fontColor)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.gray)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue, lineWidth: 1)
                    )
    }
}

struct CustomSecureField: View {
    var placeholder: String
    var fontName: String
    var fontSize: CGFloat
    var fontColor: Color
    @Binding var text: String

    var body: some View {
        SecureField(placeholder, text: $text)
                    .font(Font.custom(fontName, size: fontSize))
                    .foregroundColor(fontColor)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.gray)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue, lineWidth: 1)
                    )
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(false))
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(isRegistered: .constant(false))
    }
}
