//
//  SearchBar.swift
//  Placks
//
//  Created by Julien Heinen on 05/08/2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @State private var searchText = ""

    var body: some View {
        TextField("Search", text: $text)
            .padding(7)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
    }
}


#Preview {
    SearchBar(text: .constant("false"))

}
