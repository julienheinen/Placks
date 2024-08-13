//
//  WordDetailsView.swift
//  Placks
//
//  Created by Julien Heinen on 05/08/2024.
//

import SwiftUI
import AVKit
import AVFoundation

struct WordDetailsView: View {
    let word: Word

    var body: some View {
        VStack {
            Text(word.word)
                .font(.title)

            AsyncImage(url: URL(string: word.imageURL))

            Text(word.definition)

            VideoPlayer(player: AVPlayer(url: URL(string: word.videoURL)!))
        }
    }
}


