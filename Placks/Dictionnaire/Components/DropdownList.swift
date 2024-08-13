//
//  DropdownList.swift
//  Placks
//
//  Created by Julien Heinen on 05/08/2024.
//

import SwiftUI

struct DropdownList: View {
    let words: [Word]
    @Binding var selectedWord: Word?

    var body: some View {
        List(words, id: \.word) { word in
            Text(word.word)
                .onTapGesture {
                    selectedWord = word
                }
        }
    }
}


