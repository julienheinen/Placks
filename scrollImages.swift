//
//  scrollImages.swift
//  Placks
//
//  Created by Julien Heinen on 29/06/2021.
//

import SwiftUI

struct scrollImages: View {
    var body: some View {
        VStack {
                    Divider()
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(0..<1) { index in
                                Image("Commencer-conver")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipped()
                                    .cornerRadius(30.0)
                                Image("video-texte")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipped()
                                    .cornerRadius(30.0)
                                Image("Dictionnaire")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipped()
                                    .cornerRadius(30.0)
                                Image("Carte")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipped()
                                    .cornerRadius(30.0)
                                Image("texte-gestes")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipped()
                                    .cornerRadius(30.0)
                            }
                        }.padding()
                    }
                    Divider()
                    Spacer()
                }
        .border(Color.red, width: 1)
                  
            
            
        
        
    }
}

struct scrollImages_Previews: PreviewProvider {
    static var previews: some View {
        scrollImages()
    }
}
