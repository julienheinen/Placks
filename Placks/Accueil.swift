//
//  Accueil.swift
//  Placks
//
//  Created by Julien Heinen on 27/06/2021.
//

import SwiftUI

let myGray = Color(red: 173 / 255, green: 179 / 255, blue: 175 / 255)
let lightGray = Color(red: 220 / 255, green: 227 / 255, blue: 222 / 255)
let BackgroundColor = Color(red: 20 / 255, green: 20 / 255, blue: 20 / 255)

let BackgroundColorHeader = Color(red: 46 / 255, green: 45 / 255, blue: 44 / 255)





struct Accueil: View {
    @Binding var selectedTab: String
    @Binding var darkmode: Bool
    //Hidding Tab Menu....
    @AppStorage("email") var storedEmail: String = ""
    @AppStorage("password") var storedPassword: String = ""
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    init(darkmode: Binding<Bool>,selectedTab: Binding<String>) {self._selectedTab = selectedTab
        self._darkmode = darkmode
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        
        //Tab View with Tabs...
        TabView(selection: $selectedTab ){
            
            //Views...
            PageAccueil(colorBackground: darkmode ? BackgroundColor:.white, colorTextFriends: darkmode ? .white:.black, colorBackgroundHeader: darkmode ? BackgroundColorHeader : .white, colorTextHeader: darkmode ? .white:.purple, opacityImages: darkmode ? 0.7 : 1, backgroundColorFriendStrip: darkmode ? BackgroundColorHeader : lightGray)
                .tag("Accueil")
            
            ProfilView()
                .tag("Mon profil")
                
            Historique(BackrgoundColor: darkmode ? .black: .white)
                .tag("Historique")
            
            Paramètres(darkmode: darkmode, backgroundColor: darkmode ? BackgroundColor:.white)
                .tag("Paramètres")
            
            Aide()
                .tag("Aide")
           
            Notifications()
                .tag("Notifications")
            
            ContentView()
                .tag("Se déconnecter")


        }
        
    }
}

//Historique PART

//Tab historique struct
struct TabHistorique: View{
    
    var icon1: String
    var text1: String
    var text2: String
    var bgIcon: Color
    var colorIcon: Color
    var body: some View{
        
        HStack(){
            HStack(){
                Image(systemName: icon1)
                    .padding(5)
                    .foregroundColor(.yellow)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                Text(text1)
                    .font(.system(size: 25))
                    .foregroundColor(.white)

            }
            .padding(.trailing)
            Spacer()
            HStack{
                Text(text2)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                Image(systemName: "chevron.right")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }
        }
        
        .padding()
        .background(BackgroundColorHeader)
        .cornerRadius(20)
        .padding(.top, 1)
        
    }
}


//Historique main page

//structur of the data HIstorique (1 event)
struct Notification : Identifiable{
    var id: Int
    var Icon: String
    var Text: String
    var Time: String
}

//struct notif show (page 1)

struct TabNotif: View{
    
    var Icon: String
    var Text1: String
    var Text2: String
    
    var body: some View{
        HStack{
            HStack{
                Image(systemName: Icon)
                Text(Text1)
            }
            Spacer()
            HStack{
                Text(Text2)
                Image(systemName: "chevron.right")
            }
        }
        .foregroundColor(.white)
        .padding()
    }
}

//struct dayly block
struct DailyBlock: View
{
    let data:[Notification] = [
        Notification(id: 1, Icon: "sun.max.fill", Text: "météo", Time: "10:34")
    ]
    var date :String
    var colorBG: Color
    var colorBgOposite: Color
    
    var body: some View{
        HStack{
            Spacer()
            VStack{
                HStack{
                    Spacer()
                    Text(date)
                        .font(.system(size: 20))
                        .padding(15)
                        .foregroundColor(.white)
                    Spacer()
                        
                }
                
                .background(colorBG.cornerRadius(10).opacity(0.2).blur(radius: 2))
                .padding(.trailing, 10)
                .padding(.top,10)
                .padding(10)
                
                TabNotif(Icon: "sun.max.fill", Text1: "Météo", Text2: "10:38")
                TabNotif(Icon: "bag", Text1: "Shopping", Text2: "09:12")
                TabNotif(Icon: "car.fill", Text1: "Uber", Text2: "07:21")
                
                
                Spacer()
            }
        }
        .background(colorBgOposite.cornerRadius(20).opacity(0.1).blur(radius: 2))
        .padding(.leading, 25)
        .padding(.trailing, 25)
        .padding(.top, 50)
    }
}

// struct principal
struct Historique: View {
    
    var BackrgoundColor: Color
    
    var body: some View{
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.black, BackgroundColorHeader]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack{
                HStack(spacing: 0){
                    Spacer()
                    Text("Historique")
                        .font(.system(size: 35))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                }
                .padding(.top, 25)
                .background(BackgroundColorHeader)
                ScrollView(.vertical, showsIndicators: false)
                {
                    DailyBlock(date: "Ajourd'hui", colorBG: .black, colorBgOposite: .white)
                    DailyBlock(date: "Hier", colorBG: .black, colorBgOposite: .white)
                }
            }
            .frame(alignment: .leading)
        }
        .ignoresSafeArea()
    }
}








struct Accueil_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}

//structur of the data (cards)
struct Box : Identifiable{
    var id: Int
    var imageUrl : String
}
//structur of the data (cards)
struct FriendBox : Identifiable{
    var id: Int
    let title : String
    var imageUrl : String
}

// cards features structurs
struct BoxView: View {
    let data: Box
    var opacityImages: Double
    var action: (Int) -> Void
    

    var body: some View {
        VStack {
            Button(action: {
                self.action(data.id)
            }) {
                Image(data.imageUrl)
                    .resizable()
                    .frame(width: 90, height: 130)
                    .cornerRadius(20)
                    .opacity(opacityImages)
            }
            
            
        }
       // .background(colorBackground)
        .ignoresSafeArea()
    }
}

// cards friends structurs
struct FriendsView: View {
    
    let friends : FriendBox
    var colorTextFriends: Color
    var opacityImages: Double
    
    var body: some View{
        VStack{
            Image(self.friends.imageUrl)
                .resizable()
                .frame(width: 90, height: 90)
                .cornerRadius(50)
                .opacity(opacityImages)
            Text(self.friends.title)
                .font(.system(size: 12))
                .foregroundColor(colorTextFriends)
        }
        .padding(5)
    }
}

//All sub Views...
struct PageAccueil: View {
    @State private var selectedView: Int? = nil

    let data: [Box] = [
        Box(id: 1, imageUrl: "Commencer-conver"),
        Box(id: 2, imageUrl: "video-texte"),
        Box(id: 3, imageUrl: "Dictionnaire"),
        Box(id: 4, imageUrl: "texte-gestes"),
        Box(id: 5, imageUrl: "Carte"),
    ]

    let friends: [FriendBox] = [
        FriendBox(id: 1, title: "Julien Heinen", imageUrl: "userimage"),
        FriendBox(id: 2, title: "Alexandre Marchal", imageUrl: "userimage")
    ]

    var colorBackground: Color
    var colorTextFriends: Color
    var colorBackgroundHeader: Color
    var colorTextHeader: Color
    var opacityImages: Double
    var backgroundColorFriendStrip: Color

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack(spacing: 70) {
                        Spacer()
                        Text("Accueil")
                            .font(.system(size: 29))
                            .opacity(0.9)
                            .foregroundColor(colorTextHeader)
                            .multilineTextAlignment(.center)
                        HStack {
                            Button(action: {
                                selectedView = 4
                            }) {
                                Image(systemName: "qrcode.viewfinder")
                                    .resizable()
                                    .frame(width: 27, height: 27)
                                    .foregroundColor(colorTextFriends)
                            }
                            Button(action: {
                                selectedView = 1
                            }) {
                            Image(systemName: "person.fill.viewfinder")
                                .resizable()
                                .frame(width: 27, height: 27)
                                .padding()
                                .foregroundColor(colorTextFriends)
                            
                        }
                    }
                    }
                    .padding(.top, 70)
                    .background(colorBackgroundHeader)

                    ScrollView(.vertical, showsIndicators: false) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(data) { i in
                                    BoxView(data: i, opacityImages: opacityImages) {_ in 
                                        selectedView = i.id
                                    }
                                    .padding(5)
                                    .padding(.top, 30)
                                    .padding(.bottom, 10)
                                }
                            }
                            .padding(.leading, 20)
                        }

                        HStack {
                            Text("Amis")
                                .font(.system(size: 20))
                                .font(.headline)
                                .padding(17)
                                .foregroundColor(colorTextFriends)

                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .background(backgroundColorFriendStrip)
                        .opacity(0.7)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(friends) { j in
                                    FriendsView(friends: j, colorTextFriends: colorTextFriends, opacityImages: opacityImages)
                                }
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                            }
                            .padding(.leading, 16)
                        }
                    }

                    Spacer()
                }
            }
            .background(colorBackground)
            .ignoresSafeArea()
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarItems(trailing: NavigationLink(destination: getView(), tag: selectedView ?? 0, selection: $selectedView) {
                EmptyView()
            })

        }
    }

    func getView() -> some View {
        switch selectedView {
        case 1:
            return AnyView(QrCodeGeneratorView())
        case 2:
            return AnyView(CameraView())
        case 3:
            return AnyView(Text("Impossible"))
        case 4:
            return AnyView(QrCodeScannerView())
        case 5:
            return AnyView(ProfilView())
        default:
            return AnyView(Text("Impossible"))
        }
    }
}



struct Notifications: View {
    @State var showView = false
    var body: some View{
        
        NavigationView{
            
            Text("Notifications")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("Notifications")
            Button(action: {
                print("Connexion en cours")
                self.showView = true
            }) {
                Text(" appuyez sur moi")
            }
            
            
        }
    }
}
//struct for a setting bar
struct SettingBarView: View {
    
    var icon1: String
    var icon2: String
    var text1: String
    var text2: String
    var BgColorIcon1: Color
    var PaddingTop: CGFloat
    var TabBG: Color
    var textColor: Color
    var borderIndication: Bool
    
    var body: some View{
        
        //check if it needs 2 borders or 1
        if borderIndication == false{
            //  one setting bar
            HStack{
                HStack(spacing: 15){
                    Image(systemName: self.icon1)
                        .foregroundColor(.white)
                        .padding(4)
                        .font(.system(size: 35))
                        .background(self.BgColorIcon1)
                        .cornerRadius(10)
                    
                    Text(self.text1)
                        .foregroundColor(textColor)
                        .font(.system(size: 25))
                }
                
                Spacer()
                
                HStack{
                    Text(self.text2)
                        .foregroundColor(textColor)
                        .font(.system(size: 20))
                    Image(systemName: self.icon2)
                        .foregroundColor(textColor)
                        .font(.system(size: 20))
                }
            }
            
            .padding(.top, 15)
            .padding(.bottom, 15)
            .padding(.leading, 10)
            .padding(.trailing, 20)
            .background(TabBG)
            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.gray), alignment: .top)
            .padding(.top, PaddingTop)
        } else {
            //  one setting bar
            HStack{
                HStack(spacing: 15){
                    Image(systemName: self.icon1)
                        .foregroundColor(.white)
                        .padding(4)
                        .font(.system(size: 35))
                        .background(self.BgColorIcon1)
                        .cornerRadius(10)
                    
                    Text(self.text1)
                        .foregroundColor(textColor)
                        .font(.system(size: 25))
                }
                
                Spacer()
                
                HStack{
                    Text(self.text2)
                        .foregroundColor(textColor)
                        .font(.system(size: 20))
                    Image(systemName: self.icon2)
                        .foregroundColor(textColor)
                        .font(.system(size: 20))
                }
            }
            
            .padding(.top, 15)
            .padding(.bottom, 15)
            .padding(.leading, 10)
            .padding(.trailing, 20)
            .background(TabBG)
            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.gray), alignment: .top)
            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray), alignment: .bottom)
            .padding(.top, PaddingTop)
        }
        
        
    }
}

// struct text header
struct TextHeader : View{
    
    var textColor: Color
    
    var body: some View{
        Text("Paramètres")
            .foregroundColor(textColor)
            .padding(.top, 15)
            .font(.title)
    }
}

// setting View
struct Paramètres: View {
    
    var darkmode: Bool
    var backgroundColor: Color
    
    var body: some View{
        ZStack{
            VStack{
                HStack{
                    TextHeader(textColor: darkmode ? .white:.black)
                }
                ScrollView{
                    Button{
                        //action setting tab
                    } label: {
                        SettingBarView(icon1: "pencil.circle.fill", icon2: "chevron.right", text1: "Personnalisation", text2: "", BgColorIcon1: .blue, PaddingTop: 0, TabBG: darkmode ? BackgroundColorHeader : .white, textColor: darkmode ? .white: .black, borderIndication: true )
                    }
                    .cornerRadius(10)
                    Button{
                        //action setting tab
                    } label: {
                        SettingBarView(icon1: "person.crop.circle.fill", icon2: "chevron.right", text1: "Mon compte", text2: "", BgColorIcon1: .orange, PaddingTop: 10, TabBG: darkmode ? BackgroundColorHeader : .white, textColor: darkmode ? .white: .black, borderIndication: true)
                    }
                    .cornerRadius(10)
                    Button{
                        //action setting tab
                    } label: {
                        SettingBarView(icon1: "eye", icon2: "chevron.right", text1: "Accessibilité", text2: "", BgColorIcon1: .green, PaddingTop: 10, TabBG: darkmode ? BackgroundColorHeader : .white, textColor: darkmode ? .white: .black, borderIndication: true)
                    }
                    .cornerRadius(10)
                    Button{
                        //action setting tab
                    } label: {
                        SettingBarView(icon1: "icloud.fill", icon2: "chevron.right", text1: "Abonnement", text2: "", BgColorIcon1: .purple, PaddingTop: 10, TabBG: darkmode ? BackgroundColorHeader : .white, textColor: darkmode ? .white: .black, borderIndication: true)
                    }
                    .cornerRadius(10)
                    Button{
                        //action setting tab
                    } label: {
                        SettingBarView(icon1: "wrench.and.screwdriver", icon2: "chevron.right", text1: "Autres réglages ", text2: "", BgColorIcon1: .yellow, PaddingTop: 10, TabBG: darkmode ? BackgroundColorHeader : .white, textColor: darkmode ? .white: .black, borderIndication: true)
                    }
                    .cornerRadius(10)
                    Button{
                        //action setting tab
                    } label: {
                        SettingBarView(icon1: "keyboard", icon2: "chevron.right", text1: "À propos", text2: "", BgColorIcon1: .red, PaddingTop: 10, TabBG: darkmode ? BackgroundColorHeader : .white, textColor: darkmode ? .white: .black, borderIndication: true)
                    }
                    .cornerRadius(10)
                    
                    Text("Version 1.0 de l'application")
                    
                }
                .padding(.top, 50)
                Spacer()
            }
            .padding(.top, 70)
            
        }
        //.background(backgroundColor)
        .ignoresSafeArea()
    
    }
}

struct Aide: View {
    
    var body: some View{
        
        NavigationView{
            
            Text("Aide")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("Aide")
            
        }
    }
}



