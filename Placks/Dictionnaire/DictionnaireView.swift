//
//  DictionnaireView.swift
//  Placks
//
//  Created by Julien Heinen on 05/08/2024.
//

import SwiftUI
import CoreData
struct QuickAccessBox: View {
    let title: String
    let imageName: String

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: 120, height: 120)
                .cornerRadius(15)

            Text(title)
        }
        
    }
}



struct DictionnaireView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText = ""
    @State private var selectedWord: Word?
    @State private var words = [Word]()
    @Binding var showHamburger: Bool

    var body: some View {
        VStack(spacing: 16) {
            SearchBar(text: $searchText)
                .onChange(of: searchText) { _ in
                    // Fetch words that match the search text
                }
            VStack {
                HStack {
                    QuickAccessBox(title: "Habitation", imageName: "Habitation")
                    QuickAccessBox(title: "Institution", imageName: "Institution")
                }
                HStack {
                    QuickAccessBox(title: "Nature", imageName: "Nature")
                    QuickAccessBox(title: "Nourriture", imageName: "Nourriture")
                }
                HStack {
                    QuickAccessBox(title: "Animaux", imageName: "Animaux")
                    QuickAccessBox(title: "Transports", imageName: "Transport")
                }
                HStack{
                    QuickAccessBox(title: "Relations", imageName: "Famille")
                    QuickAccessBox(title: "Mode", imageName: "Mode")
                }
            }
            if !searchText.isEmpty {
                DropdownList(words: words, selectedWord: $selectedWord)
            }

            if let selectedWord = selectedWord {
                WordDetailsView(word: selectedWord)
            }
        }
        .onAppear {
            showHamburger = false

        }
    }
}


#Preview {
    DictionnaireView(showHamburger: .constant(false))
}

