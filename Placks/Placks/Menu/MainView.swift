//
//  MainView.swift
//  Placks
//
//  Created by Julien Heinen on 27/06/2021.
//

import SwiftUI

struct MainView: View {
    //selected Tab...
    @State var selectedTab = "Accueil"
    @State var showMenu = false
    var body: some View {
        
        ZStack{
            Color("blue")
                .ignoresSafeArea()
            
            //Side Menu...
            SideMenu(selectedTab: $selectedTab)
            
            ZStack{
                
           //Two backgrounds Cards...
                Color.white
                    .opacity(0.5)
                    .cornerRadius(showMenu ? 15 : 0)
                    //Shadow...
                    .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? 25 : 0)
                    .padding(.vertical,30)
            
            Accueil(selectedTab: $selectedTab)
                .cornerRadius(showMenu ? 15 : 0)
                
                }
                //Scaling and moving
                .scaleEffect(showMenu ? 0.84 : 1)
                .offset(x: showMenu ? getRect().width - 120 : 0)
                .ignoresSafeArea()
                .overlay(
                
                    //Menu Button...
                    Button(action: {
                        withAnimation(.spring()){
                            showMenu.toggle()
                        }
                    }, label: {
                       // Animated Drawer Button...
                        VStack(spacing: 5){
                            
                            Capsule()
                                .fill(showMenu ? Color.white : Color.primary)
                                .frame(width: 30, height: 3)
                            // Rotating...
                                .rotationEffect(.init(degrees: showMenu ? -50 : 0))
                                .offset(x: showMenu ? 2 : 0, y: showMenu ? 9 : 0)
                            VStack(spacing: 5){
                                
                                Capsule()
                                    .fill(showMenu ? Color.white : Color.primary)
                                    .frame(width: 30, height: 3)
                                //Movig Up when clicked...
                                Capsule()
                                    .fill(showMenu ? Color.white : Color.primary)
                                    .frame(width: 30, height: 3)
                                    .offset(y: showMenu ? -8 : 0)
                            }
                            .rotationEffect(.init(degrees: showMenu ? 50 : 0))
                        }
                        
                        
                            
                            
                    })
                    .padding()
                    .position(x: 30, y: 55)
                    
                    ,alignment: .topLeading
                )
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


//Extending View to get Screen Size...
extension View{
    func getRect()->CGRect{
        
        return UIScreen.main.bounds
    }
}
