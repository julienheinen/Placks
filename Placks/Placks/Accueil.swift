//
//  Accueil.swift
//  Placks
//
//  Created by Julien Heinen on 27/06/2021.
//

import SwiftUI

struct Accueil: View {
    @Binding var selectedTab: String
    
    //Hidding Tab Menu....
    init(selectedTab: Binding<String>) {self._selectedTab = selectedTab
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        
        //Tab View with Tabs...
        TabView(selection: $selectedTab ){
            
            //Views...
            PageAccueil()
                .tag("Accueil")
            
            Historique()
                .tag("Historique")
            
            Paramètres()
                .tag("Paramètres")
            
            Aide()
                .tag("Aide")
           
            Notifications()
                .tag("Notifications")
        }
    }
}

struct Accueil_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//All sub Views...
struct PageAccueil: View {
    
    var body: some View{
        ZStack{
        
            
            
            HStack(){
                           
                          
                           Text("Accueil")
                               .font(.title)
                               .fontWeight(.medium)
                               .foregroundColor(Color.purple)
                               .multilineTextAlignment(.center)
                                .offset(x: 20, y: -310)
                           Image(systemName: "qrcode.viewfinder")
                               .resizable()
                               .frame(width: 27, height: 27)
                               .offset(x: 40, y: -310)
                           
                           Image(systemName: "person.fill.viewfinder")
                               .resizable()
                               .frame(width: 27, height: 27)
                               .offset(x: 61, y: -310)
                Text("test")
                           
                        
                       
            }
                       .padding()

            scrollImages()
        }
    }
}

struct Historique: View {
    
    var body: some View{
        
        NavigationView{
            
            Text("Historique")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("Historique")
            
        }
    }
}

struct Notifications: View {
    
    var body: some View{
        
        NavigationView{
            
            Text("Notifications")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("Notifications")
            
        }
    }
}

struct Paramètres: View {
    
    var body: some View{
        
    NavigationView{
            
            Text("Paramètres")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("Paramètres")
            
        }
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
