import SwiftUI

struct ContentView: View {

    @State private var isLoggedIn: Bool = false
    @State private var isLoading: Bool = true
    @AppStorage("isComplete") var isComplet: Bool = false
    
    //  informations
    @AppStorage("email") var storedEmail: String = ""
    @AppStorage("user_id") var user_id: String = ""
    @AppStorage("password") var storedPassword: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("birthDate") var birthDate: String = ""
    @AppStorage("country") var country: String = ""
    @AppStorage("region") var region: String = ""
    @AppStorage("ls") var ls: String = ""
    @AppStorage("pp_profil") var pp_profil: String = ""

    var body: some View {
        Group {
            if isLoading {
                LoadingScreen()
            } else if isLoggedIn {
                if !isComplet {
                    InformationsView()
                } else {
                    MainView()
                    
                }
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
        .onAppear {
            if !storedEmail.isEmpty && !user_id.isEmpty && !storedPassword.isEmpty {
                DatabaseManager.shared.loginUser(email: storedEmail, password: storedPassword) { success, message, userId, isComplete in
                    if success, let userId = userId {
                        self.isComplet = isComplete
                        self.user_id = userId
DatabaseManager.shared.loadData(storedEmail: storedEmail, user_id: userId) { success, userData in
        print("Data loaded successfully. User data: \(userData)")

    if success, let userData = userData {
        // Traitement des informations récupérées
        self.firstName = userData.prenom
        self.lastName = userData.nom
        self.birthDate = userData.date_de_naissance ?? ""
        self.country = userData.pays
        self.region = userData.region
        self.ls = userData.langue_des_signes ?? ""
        self.pp_profil = userData.photo
        

        // Redirection vers MainView
        self.isLoggedIn = true
    } else {
        // Gestion de l'échec de récupération des informations
        // ...
    }
}
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.isLoading = false
                    }
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.isLoading = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
