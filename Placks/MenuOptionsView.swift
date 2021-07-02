//
//  MenuOptionsView.swift
//  Placks
//
//  Created by Julien Heinen on 05/06/2021.
//

import SwiftUI

struct MenuOptionsView: View {
    var body: some View {
        HStack(spacing: 16){
            Image(systemName: "person")
                .frame(width: 24, height: 24)
            
            Text("Gérer mon profil")
                .font(.system(size: 13, weight: .semibold))
            
            Spacer()
        }
        .foregroundColor(.white)
        .padding()
    }
}

struct MenuOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        MenuOptionsView()
    }
}
