//
//  InformationsView.swift
//  Placks
//
//  Created by Julien Heinen on 27/05/2024.
//

import SwiftUI
import Combine

private let dateFormatter: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withFullDate,  .withDashSeparatorInDate]
    return formatter
}()

struct InformationsView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var birthDate: Date = Date()
    @State private var gender: Gender = .male
    @State private var country: String = ""
    @State private var region: String = ""
    @State private var ls: String = ""
    @AppStorage("isComplete") var isComplet: Bool = false
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @AppStorage("email") var storedEmail: String = ""
    @AppStorage("user_id") var user_id: String = ""
    @State private var currentPage: Page = .name
    @State private var profilePicture: String = "vache"



    var body: some View {
        VStack {
            // Progress indicator
            HStack(spacing: 20) {
                ForEach(0..<6) { index in
                    Circle()
                        .fill(index < currentPage.rawValue ? Color.blue : Color.gray)
                        .frame(width: 10, height: 10)
                }
            }
            .padding()

            // Current page
            switch currentPage {
            case .name:
                NamePage(firstName: $firstName, lastName: $lastName, onNext: nextPage)
            case .birthdate:
                BirthdatePage(birthDate: $birthDate, gender: $gender, onNext: nextPage)
            case .country:
                CountryPage(country: $country, onNext: nextPage)
            case .region:
                RegionPage(country: country, region: $region, onNext: nextPage)
            case .ls:
                LanguagePage(ls: $ls, onNext: nextPage)
            case .profilePicture:
                ProfilePicturePage(profilePicture: $profilePicture, onNext: nextPage)
            case .summary:
                SummaryPage(firstName: firstName, lastName: lastName, birthDate: birthDate, gender: gender, country: country, region: region, ls:ls, profilePicture:profilePicture, onConfirm: submitData)
            }

            // Error message
            if showError {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

            Spacer()

            // Navigation buttons
            HStack {
                // Back button
Button(action: {
    if currentPage != .name {
        currentPage = Page(rawValue: currentPage.rawValue - 1) ?? .name
    }
}) {
    ZStack {
        Circle()
            .fill(Color.gray)
            .frame(width: 40, height: 40)
        Image(systemName: "arrow.left")
            .foregroundColor(.white)
    }
}
.disabled(currentPage == .name)

                Spacer()

                // Next button
                Button(action: {
                    if currentPage != .summary {
                        nextPage()
                    } else {
                        submitData()
                    }
                }) {
                        HStack {
                            Text(currentPage == .summary ? "Confirmer" : "Continuer")
                            Image(systemName: currentPage == .summary ? "checkmark" : "arrow.right")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }

    private func nextPage() {
        currentPage = currentPage.next()
    }

    private func submitData() {

        let informations = DatabaseManager.Informations(
            email: storedEmail,
            user_id: user_id,
            firstName: firstName,
            lastName: lastName,
            ls: ls,
            country: country,
            region: region,
            gender: gender.rawValue,
            birthDate: dateFormatter.string(from: birthDate),
            profilePicture: profilePicture
        )
        DatabaseManager.putData(informations: informations) { success, message in
            DispatchQueue.main.async {
                if success {
                    self.isComplet = true
                } else {
                    self.errorMessage = message
                    self.showError = true
                }

            }    
            
        }
    }

}



enum Page: Int {
    case name = 0
    case birthdate
    case country
    case region
    case ls
    case profilePicture
    case summary

    func next() -> Page {
        switch self {
        case .name:
            return .birthdate
        case .birthdate:
            return .country
        case .country:
            return .region
        case .region:
            return .ls 
        case .ls: 
            return .profilePicture
        case .profilePicture:
            return .summary
        case .summary:
            return .name
        }
    }
}

struct NamePage: View {
    @Binding var firstName: String
    @Binding var lastName: String
    var onNext: () -> Void
    
    var body: some View {
        VStack {
        Text("Comment vous appelez-vous ?")
            .font(.title)
            .padding(.bottom, 10)
            .padding()

            TextField("Prénom", text: $firstName)
                .textFieldStyle(GradientTextFieldBackground(systemImageString: "person"))
                .padding()

            TextField("Nom de famille", text: $lastName)
                .textFieldStyle(GradientTextFieldBackground(systemImageString: "person.3.fill"))
                .padding()
        }
    }
}

struct BirthdatePage: View {
    @Binding var birthDate: Date
    @Binding var gender: Gender
    @State private var otherGender: String = ""
    @State private var isShowingOtherGenderPicker: Bool = false
    var onNext: () -> Void

    private let otherGenders = [
    "Non-binaire",
    "Transgenre",
    "Agenre",
    "Fluide dans le genre",
    "Bigenre",
    "Poly Genre",
    "Genre non-conforme",
    "M to F",
    "F to M",
    "Pan Genre",
    "Dauphin",
    "Lion",
    "Éléphant",
    "Cheval",
    "Poney",
    "Vache",
    "Cochon",
    "Papillon",
    "Panzerkampfwage",
    "Avion",
    "Hélicoptère",
    "Bateau",
    "Sous-marin",
    "Métro RATP",
    "TGV SNCF",
    "Tramway de Nancy",
    "Bus de la STAN",
    "Vélo",
    "Trottinette",
    "Roller",
    "Skateboard",
    "Tractopelle",
    "Grue",
    "Robot",
    "Ordinateur",
    "Voiture",
    "Cis Genre",
    "Cactus",
    "Poisson",
    "Poisson rouge",
    "Poisson clown",
    "Poisson lune",
    "Poisson volant",
    "Poisson scie",
    "Poisson chat",
    "fleur",
    "Rose",
    "Tulipe",
    "Pâquerette",
    "Marguerite",
    "Jonquille",
    "Lys",
    "Orchidée",
    "Iris",
    "Lilas",
    "Muguet",
    "Coquelicot",
    "Pivoine",
    "Chrysanthème",
    "Dahlia",
    "Tournesol",
    "Hortensia",
    "Camélia",
    "Bleuet",
    "Glaïeul",
    "Freesia",
    "Géranium",
    "Jacinthe",
    "Lavande",
    "Mimosa",
    "Myosotis",
    "Narcisse",
    "Oeillet",
    "Pensée"
]

    var body: some View {
        VStack {
            Text("Quand êtes-vous née ? ")
                .font(.title)
                .padding(.bottom, 10)
                .padding()

            HStack {
                Image(systemName: "calendar")
                DatePicker("Date de naisssance", selection: $birthDate, displayedComponents: .date)
            }
            .padding()

            Picker("Gender", selection: $gender) {
                Text("Homme").tag(Gender.male)
                Text("Femme").tag(Gender.female)
                Text("Autre").tag(Gender.other)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if gender == .other {
                VStack {
                    Text("Please select your gender:")
                        .font(.headline)
                        .padding(.bottom, 5)

                    Picker("Other Gender", selection: $otherGender) {
                        ForEach(otherGenders, id: \.self) { gender in
                            Text(gender)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                }
            }
        }
    }
}


struct CountryPage: View {
    @Binding var country: String
    @State private var isEditing = false
    var onNext: () -> Void



    var body: some View {
        VStack {
            Text("Nous aimerions connaître votre pays")
                .font(.title)
                .padding(.bottom, 10)
                .padding()

            // Country field with autocompletion
            TextField("Country", text: $country, onEditingChanged: { editing in
                self.isEditing = editing
            })
            .textFieldStyle(GradientTextFieldBackground(systemImageString: isEditing ? "magnifyingglass" : "globe.europe.africa"))
            .padding()


            // Country suggestions
            List(DatabaseManager.shared.countries.keys.sorted().filter { $0.hasPrefix(country) }, id: \.self) { country in
                Button(action: {
                    self.country = country
                    onNext()
                }) {
                    HStack {
                        if let countryCode = DatabaseManager.shared.countries[country] {
                            AsyncImage(url: URL(string: "https://flagsapi.com/\(countryCode)/flat/64.png")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 16)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 24, height: 16)
                            }
                        }
                        Text(country)
                            .font(.system(size: 16, weight: .medium))
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct RegionPage: View {
    let country: String
    @Binding var region: String
    var onNext: () -> Void
    @State private var regions = [String]()
    @State private var isLoading = false

    var body: some View {
        VStack {
            Text("Et aussi votre région")
                .font(.title)
                .padding(.bottom, 10)
                .padding()

            // Region field
            TextField("Region", text: $region)
                .textFieldStyle(GradientTextFieldBackground(systemImageString: "mountain.2"))
                .padding()

            // Region suggestions
            if isLoading {
                ProgressView()
            } else {
                List(regions.filter { $0.hasPrefix(region) }, id: \.self) { region in
                    Button(action: {
                        self.region = region
                        onNext()
                    }) {
                        Text(region)
                            .font(.system(size: 16, weight: .medium))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .onAppear {
            fetchRegions()
        }
    }

    private func fetchRegions() {
        isLoading = true
        if let countryCode = DatabaseManager.shared.countries[country] {
            DatabaseManager.shared.fetchRegions(countryCode: countryCode) { regions in
                DispatchQueue.main.async {
                    self.regions = regions ?? []
                    self.isLoading = false
                }
            }
        }
    }
}




struct LanguagePage: View {
    @Binding var ls: String
    var onNext: () -> Void

    private let languages = [
        "LSF (France)": Color.red,
        "ASL (USA)": Color.blue,
        "BSL (British)": Color.green,
        "Auslan (Australia)": Color.yellow,
        "DGS (Germany)": Color.orange,
        "IS (International)": Color.purple,
        "Chinese Sign Language": Color.pink,
        "Indian Sign Language": Color.teal,
        "Japanese Sign Language": Color.indigo
    ]

 var body: some View {
        VStack {
            Text("Quelle langue des signes utilisez-vous ?")
                .font(.title)
                .padding(.bottom, 10)
                .padding()

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(Array(languages.keys), id: \.self) { language in
                        Button(action: {
                            self.ls = language
                        }) {
                            Text(language)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(languages[language])
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(self.ls == language ? Color.blue : Color.clear, lineWidth: 2)
                                )
                        }
                    }
                }
                .padding()
            }
        }
    }
}



struct GradientTextFieldBackground: TextFieldStyle {

    

    let systemImageString: String

    



    func _body(configuration: TextField<Self._Label>) -> some View {

        ZStack {

            RoundedRectangle(cornerRadius: 5.0)

                .stroke(

                    LinearGradient(

                        colors: [

                            .red,

                            .blue

                        ],

                        startPoint: .leading,

                        endPoint: .trailing

                    )

                )

                .frame(height: 40)

            

            HStack {

                Image(systemName: systemImageString)

                // Reference the TextField here

                configuration

            }

            .padding(.leading)

            .foregroundColor(.gray)

        }

    }

}

 struct ProfilePicturePage: View {
    @Binding var profilePicture: String
    var onNext: () -> Void

    private let profilePictures = ["vache", "chat", "hibou", "cheval", "paresseux"]

    var body: some View {
        VStack {
            Text("Choisissez votre photo de profil")
                .font(.title)
                .padding(.bottom, 10)
                .padding()

            ScrollView {
                VStack(spacing: 10) {
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
        }
    }
}



struct SummaryPage: View {
    var firstName: String
    var lastName: String
    var birthDate: Date
    var gender: Gender
    var country: String
    var region: String
    var ls: String
    var profilePicture: String
    var onConfirm: () -> Void
    
    
    var body: some View {
VStack(alignment: .leading, spacing: 24) {
                Image(profilePicture) 
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .cornerRadius(50)
                .padding(.bottom, 10)

            Text("Voici vos informations")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 16)

            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.blue)
                    Text("Name: \(firstName) \(lastName)")
                        .font(.headline)
                }

                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.blue)
                    Text("Birthdate: \(birthDate, formatter: dateFormatter)")
                        .font(.title2)
                }

                HStack {
                    Image(systemName: "person.2.square.stack.fill")
                        .foregroundColor(.blue)
                    Text("Gender: \(gender.rawValue)")
                        .font(.title2)
                }

                HStack {
                    Image(systemName: "globe")
                        .foregroundColor(.blue)
                    Text("Country: \(country)")
                        .font(.title2)
                }

                HStack {
                    Image(systemName: "map.fill")
                        .foregroundColor(.blue)
                    Text("Region: \(region)")
                        .font(.title2)
                }
                HStack {
                    Image(systemName: "flag.fill")
                        .foregroundColor(.blue)
                    Text("Language: \(ls)")
                        .font(.title2)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(20)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        
    }
}


enum Gender: String {
    case male
    case female
    case other
}
