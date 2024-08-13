//
//  TitleRow.swift
//  ChatApp
//
//  Created by Stephanie Diep on 2022-01-11.
//

import SwiftUI

struct TitleRow: View {
    var imageName: String
    var name: String

    var body: some View {
        HStack(spacing: 20) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55, height: 50)
                .cornerRadius(50)

            VStack(alignment: .leading) {
                Text(name)
                    .font(.title).bold()

                Text("Online")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: "phone.fill")
                .foregroundColor(.gray)
                .padding(10)
                .background(.white)
                .cornerRadius(50)
        }
        .padding()
    }
}

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow(imageName: "vache", name: "inconnu")
            .background(Color("Peach"))
    }
}
