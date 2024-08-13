//
//  MainView.swift
//  Placks
//
//  Created by Julien Heinen on 27/06/2021.
//

import SwiftUI

struct MainView: View {
    
    var lightBlackGradient = Color(red: 54 / 255, green: 53 / 255, blue: 50 / 255)

    
    //selected Tab...
    @State var selectedTab = "Acceuil"
    @State var showMenu = false
    @State var showHamburger = true
    @State var darkmode = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    
    var body: some View {
        
        ZStack{
            
            LinearView(topColor: darkmode ? lightBlackGradient: .blue,  bottomColor: darkmode ? .black: .purple, opacity: darkmode ? 1:0.7)
            
            //Side Menu...
            SideMenu(selectedTab: $selectedTab, darkmode: $darkmode, showMenu: $showMenu)
            
            ZStack{
                
           //Two backgrounds Cards...
                Color.white
                    .opacity(0.5)
                    .cornerRadius(showMenu ? 15 : 0)
                    //Shadow...
                    .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? 25 : 0)
                    .padding(.vertical,30)
            
                Accueil(darkmode: $darkmode, selectedTab: $selectedTab, showHamburger: $showHamburger)

                .cornerRadius(showMenu ? 15 : 0)
                }
            
                //Scaling and moving
                .scaleEffect(showMenu ? 0.84 : 1)
                .offset(x: showMenu ? getRect().width - 120 : 0)
            .ignoresSafeArea()
            .overlay(
                showHamburger ?
                    // Menu Button...
                    Button(action: {
                        withAnimation(.spring()){
                            showMenu.toggle()
                        }
                    }, label: {
                        // Animated Drawer Button...
                        VStack(spacing: 5){
                            MenuButtonView(colorLinesHomePage: darkmode ? .white : .black, showMenu: showMenu)
                        }
                    })
                    .padding()
                    .position(x: 30, y: 55)
                    : nil,
                alignment: .topLeading
            )
            .gesture(
                showHamburger ?
                    DragGesture(minimumDistance: 50)
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                self.showMenu = true
                            }
                        }
                    : nil
            )
        }
    }
}

// struct to make the linear gradient on the side menu (light / dark mode)
struct LinearView: View {
    
    var topColor : Color
    var bottomColor : Color
    var opacity: Double
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [topColor,bottomColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            .opacity(opacity)
    }
}

//struct for the menu button
struct MenuButtonView: View{
    
    var colorLinesHomePage: Color
    var showMenu: Bool
    
    var body: some View{
        Capsule()
            .fill(showMenu ? Color.white : colorLinesHomePage)
            .frame(width: 30, height: 3)
        // Rotating...
            .rotationEffect(.init(degrees: showMenu ? -50 : 0))
            .offset(x: showMenu ? 2 : 0, y: showMenu ? 9 : 0)
        VStack(spacing: 5){
            
            Capsule()
                .fill(showMenu ? Color.white : colorLinesHomePage)
                .frame(width: 30, height: 3)
            //Movig Up when clicked...
            Capsule()
                .fill(showMenu ? Color.white : colorLinesHomePage)
                .frame(width: 30, height: 3)
                .offset(y: showMenu ? -8 : 0)
        }
        .rotationEffect(.init(degrees: showMenu ? 50 : 0))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.light)
    }
}


//Extending View to get Screen Size...
extension View{
    func getRect()->CGRect{
        
        return UIScreen.main.bounds
    }
}
