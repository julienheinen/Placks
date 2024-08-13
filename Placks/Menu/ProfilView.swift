//
//  ProfilView.swift
//  Placks
//
//  Created by Julien Heinen on 15/05/2024.
//

import SwiftUI
import Combine

struct ProfilView: View {

    @State private var isEditingProfilePicture = false
    @State private var isEditing = false
    @State private var showUpdateSuccessAlert = false
    @State private var showUpdateFailureAlert = false

    //Informations
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("birthDate") var birthDate: String = ""
    @AppStorage("country") var country: String = ""
    @AppStorage("region") var region: String = ""
    @AppStorage("ls") var ls: String = ""
    @AppStorage("email") var storedEmail: String = ""
    @AppStorage("pp_profil") var pp_profil: String = ""
    @AppStorage("user_id") var user_id: String = ""

    var body: some View {
        VStack {
            HStack {
                Spacer()
Button(action: {
    if isEditing {
        let userUpdate = DatabaseManager.UserUpdate(
            email: storedEmail,
            user_id: user_id,
            firstName: firstName,
            lastName: lastName,
            ls: ls,
            country: country,
            birthDate: birthDate,
            profilePicture: pp_profil
        )
        DatabaseManager.shared.updateData(userUpdate: userUpdate) { success, message in
            if success {
                showUpdateSuccessAlert = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    showUpdateSuccessAlert = false
                }
            } else {
                showUpdateFailureAlert = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    showUpdateFailureAlert = false
                }
            }
        }
    }
    isEditing.toggle()
}) {
    Text(isEditing ? "Confirmer" : "Éditer")
}
               
                .alert(isPresented: $showUpdateSuccessAlert) {
                Alert(
                    title: Text("Mise à jour réussie"),
                    message: Text("Vos informations ont été mises à jour avec succès."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .alert(isPresented: $showUpdateFailureAlert) {
                Alert(
                    title: Text("Échec de la mise à jour"),
                    message: Text("Une erreur s'est produite lors de la mise à jour de vos informations."),
                    dismissButton: .default(Text("OK"))
                )
            }
                
            }
            .padding()

            Text("Mon Profil")
                .font(.title)
                .padding(.bottom, 10)
                .padding()

            ZStack(alignment: .bottomTrailing) {
                Image(pp_profil)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 170, height: 170)
                    .cornerRadius(300)
                    .padding(.top, 5)
                    .padding()

                Button(action: {
                    self.isEditingProfilePicture = true
                }) {
                    Image(systemName: "pencil.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.gray)
                        .padding()
                }
            }

            if isEditingProfilePicture {
                ProfilePictureSelectionView(isEditingProfilePicture: $isEditingProfilePicture, pp_profil: $pp_profil)
            } else {
                if isEditing {
                    TextField("Prénom", text: $firstName)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    TextField("Nom", text: $lastName)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                } else {
                    HStack {
                        Text(lastName)
                            .font(.title2)
                        Text(firstName)
                            .font(.title2)
                    }
                    .padding(.horizontal)
                }

                if isEditing {
                    TextField("Email", text: $storedEmail)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                } else {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "envelope")
                            Text(storedEmail)
                                .padding()
                        }
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    }
                }

if isEditing {
    TextField("Date de naissance", text: $birthDate)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        )
} else {
    HStack {
        Image(systemName: "calendar")
        Text(birthDate)
            .padding()
    }
    .padding(.horizontal)
    .overlay(
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color.gray, lineWidth: 1)
    )
}

if isEditing {
    TextField("Niveau de langue des signes", text: $ls)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        )
} else {
    HStack {
        Image(systemName: "hand.raised.fingers.spread")
        Text(ls)
            .padding()
    }
    .padding(.horizontal)
    .overlay(
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color.gray, lineWidth: 1)
    )
}

if isEditing {
    TextField("Pays", text: $country)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        )
} else {
    HStack {
        if let countryCode = DatabaseManager.shared.countries[country] {
            AsyncImage(url: URL(string: "https://flagsapi.com/\(countryCode)/flat/64.png")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 22)
            } placeholder: {
                ProgressView()
                    .frame(width: 24, height: 16)
            }
        }
        Text(country)
    }
    .padding()
    .overlay(
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color.gray, lineWidth: 1)
    )
    .padding(.horizontal)
}

if isEditing {
    TextField("Région", text: $region)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        )
} else {
    HStack {
        Image(systemName: "map")
        Text(region)
            .padding()
    }
    .padding(.horizontal)
    .overlay(
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color.gray, lineWidth: 1)
    )
}

            Spacer()
        }
        }
    }
}
struct ProfilePictureSelectionView: View {
    @Binding var isEditingProfilePicture: Bool
    @Binding var pp_profil: String
    @State private var profilePicture: String = ""
    private let profilePictures = ["vache", "chat", "hibou", "cheval", "paresseux"]

    var body: some View {
        VStack {
            Text("Choisissez votre photo de profil")
                .font(.title)
                .padding(.bottom, 10)
                .padding()

            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 10) {
                    ForEach(profilePictures, id: \.self) { picture in
                        Button(action: {
                            self.profilePicture = picture
                        }) {
                            Image(picture)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .cornerRadius(50)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(self.profilePicture == picture ? Color.blue : Color.clear, lineWidth: 2)
                                )
                        }
                    }
                }
                .padding()
            }

            Button(action: {
                pp_profil = profilePicture
                isEditingProfilePicture = false
            }) {
                Text("Confirmer")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
            }
        }
    }
}



#Preview {
    ProfilView()
}
