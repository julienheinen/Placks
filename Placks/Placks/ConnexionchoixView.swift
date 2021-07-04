//
//  PresentationView.swift
//  Placks
//
//  Created by Julien Heinen on 01/06/2021.
//

import SwiftUI

struct ConnexionchoixView: View {
    var body: some View {
        NavigationView{
        ZStack{
            
            VStack{
                    
                Text("Connexion")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom,15)
                    .foregroundColor(.orange)
                
                
                        NavigationLink(destination: ConnexionbamView()){
                            Text("Se connecter avec Bambol")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 260, height: 50)
                                .background(Color.black)
                                .cornerRadius(35.0)
                        }
                
                
                Image("SignApple")
                    .resizable()
                    .frame(width: 300, height: 70)
                    .clipped()
                    .padding(.bottom,15)
                  
                Text("Ne pas utiliser de comptes")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 260, height: 50)
                    .background(Color.blue)
                    .cornerRadius(35.0)
           
                }
            }
    }
}
}

struct ConnexionchoixView_Previews: PreviewProvider {
    static var previews: some View {
        ConnexionchoixView()
           }
}
