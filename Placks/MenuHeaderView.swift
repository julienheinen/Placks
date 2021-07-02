//
//  MenuHeaderView.swift
//  Placks
//
//  Created by Julien Heinen on 05/06/2021.
//

import SwiftUI

struct MenuHeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("userimage")
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 64, height: 63)
                .clipShape(Circle())
                .padding(.bottom, 16)
                
            
            Text("Julien Heinen")
                .font(.system(size: 24, weight: .semibold))
            
            Text("#julienheinen")
                .font(.system(size: 14))
                .padding(.bottom, 24)
            
            HStack(spacing: 12){
                HStack(spacing: 4) {
                    Text("12").bold()
                    Text("Amis                                               ")
                }
            }
            
            
            
            Spacer()
        }.padding()
}
}
struct MenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MenuHeaderView()
    }
}
