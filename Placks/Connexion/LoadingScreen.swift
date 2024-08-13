//
//  QrCodeGeneratorView.swift
//  Placks
//
//  Created by Julien Heinen on 10/05/2024.
//
import SwiftUI

struct LoadingScreen: View {
    @State private var isLoading = false
    @State private var randomQuote = ""
    let rotationTime: Double = 0.75
    let animationTime: Double = 1.9
    let fullRotation: Angle = .degrees(360)
    static let initialDegree: Angle = .degrees(270)

    @State var spinnerStart: CGFloat = 0.0
    @State var spinnerEndS1: CGFloat = 0.03
    @State var spinnerEndS2S3: CGFloat = 0.03

    @State var rotationDegreeS1 = initialDegree
    @State var rotationDegreeS2 = initialDegree
    @State var rotationDegreeS3 = initialDegree

    private let quotes = [
        "La langue des signes n'est pas universelle, chaque pays a sa propre langue des signes, avec sa propre grammaire et son propre vocabulaire.",
        "La langue des signes américaine (ASL) est différente de la langue des signes britannique (BSL), même si les deux pays partagent la même langue parlée.",
        "La langue des signes est une langue visuelle et spatiale, elle utilise les mouvements des mains, les expressions faciales et la posture du corps pour communiquer.",
        "La langue des signes a été reconnue comme une langue officielle aux États-Unis en 1965.",
        "La langue des signes française (LSF) a été développée au 18ème siècle par l'abbé Charles-Michel de l'Épée, considéré comme le 'père des sourds'.",
        "La première école pour sourds a été fondée à Paris en 1760 par l'abbé de l'Épée, où il a développé une méthode d'enseignement basée sur la langue des signes.",
        "La langue des signes n'est pas un code pour la langue parlée, c'est une langue à part entière avec sa propre grammaire et sa propre syntaxe.",
        "En 1880, le Congrès de Milan a interdit l'usage de la langue des signes dans les écoles pour sourds, favorisant l'oralisme. Cette décision a eu un impact négatif sur l'éducation des sourds pendant de nombreuses décennies.",
        "La langue des signes a été utilisée pour la première fois dans l'éducation des sourds en Espagne au 16ème siècle par Pedro Ponce de León, un moine bénédictin.",
        "La langue des signes a été reconnue comme une langue à part entière par l'Organisation des Nations Unies en 1991.",
        "L'abbé de l'Épée a adapté des signes naturels utilisés par les sourds pour créer un système de communication plus structuré, jetant les bases de la langue des signes moderne.",
        "La langue des signes a été interdite dans de nombreuses écoles pour sourds au 19ème siècle, en faveur de l'oralisme, un mouvement qui croyait que les sourds devaient apprendre à parler au lieu d'utiliser des signes.",
        "En France, la langue des signes a été interdite dans les écoles en 1880 à la suite du Congrès de Milan, mais elle a été réintroduite dans les années 1970 après des décennies de lutte pour sa reconnaissance.",
        "La langue des signes peut être utilisée pour exprimer des émotions et des nuances subtiles, grâce à l'utilisation des expressions faciales et de la posture du corps.",
        "La langue des signes internationale (IS) a été développée pour faciliter la communication entre les personnes sourdes de différentes nationalités lors des événements internationaux.",
        "En 1988, les étudiants sourds de l'Université Gallaudet aux États-Unis ont mené une protestation historique appelée 'Deaf President Now', qui a conduit à la nomination du premier président sourd de l'université.",
        "La langue des signes française (LSF) a influencé le développement de la langue des signes américaine (ASL) lorsque Thomas Hopkins Gallaudet a appris la LSF en France et l'a introduite aux États-Unis au début du 19ème siècle."
    ]


var body: some View {
    ZStack {
        ConnectionStatusView()

        VStack {
            Spacer()


            ZStack {
                // S3
                SpinnerCircle(start: spinnerStart, end: spinnerEndS2S3, rotation: rotationDegreeS3, color: Color.red)

                // S2
                SpinnerCircle(start: spinnerStart, end: spinnerEndS2S3, rotation: rotationDegreeS2, color: Color.purple)

                // S1
                SpinnerCircle(start: spinnerStart, end: spinnerEndS1, rotation: rotationDegreeS1, color: Color.blue)
            }
            .frame(width: 200, height: 200)
            .onAppear() {
                self.isLoading = true
                self.randomQuote = quotes.randomElement() ?? ""
                self.animateSpinner()
                Timer.scheduledTimer(withTimeInterval: animationTime, repeats: true) { (mainTimer) in
                    self.animateSpinner()
                }
            }

            Spacer()
            Text("Le saviez-vous!")
                .foregroundColor(.white)
                .font(.title3)
                .padding()
                .background(Color.purple)
                .cornerRadius(10)
            Text(randomQuote)
                .foregroundColor(.gray)
                .font(.headline)
                .padding()
                .onTapGesture {
                    self.randomQuote = quotes.randomElement() ?? ""
                }
        }
    }
}


    // MARK: Animation methods
    func animateSpinner(with duration: Double, completion: @escaping (() -> Void)) {
        Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
            withAnimation(Animation.easeInOut(duration: self.rotationTime)) {
                completion()
            }
        }
    }

    func animateSpinner() {
        animateSpinner(with: rotationTime) { self.spinnerEndS1 = 1.0 }

        animateSpinner(with: (rotationTime * 2) - 0.025) {
            self.rotationDegreeS1 += fullRotation
            self.spinnerEndS2S3 = 0.8
        }

        animateSpinner(with: (rotationTime * 2)) {
            self.spinnerEndS1 = 0.03
            self.spinnerEndS2S3 = 0.03
        }

        animateSpinner(with: (rotationTime * 2) + 0.0525) { self.rotationDegreeS2 += fullRotation }

        animateSpinner(with: (rotationTime * 2) + 0.225) { self.rotationDegreeS3 += fullRotation }
    }
}

// MARK: SpinnerCircle

struct SpinnerCircle: View {
    var start: CGFloat
    var end: CGFloat
    var rotation: Angle
    var color: Color

    var body: some View {
        Circle()
            .trim(from: start, to: end)
            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
            .fill(color)
            .rotationEffect(rotation)
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}
