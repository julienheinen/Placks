import SwiftUI

struct LoadingScreen: View {
    @State private var isLoading = false
    @State private var randomQuote = ""
    let rotationTime: Double = 0.75
    let animationTime: Double = 1.9 // Sum of all animation times
    let fullRotation: Angle = .degrees(360)
    static let initialDegree: Angle = .degrees(270)

    @State var spinnerStart: CGFloat = 0.0
    @State var spinnerEndS1: CGFloat = 0.03
    @State var spinnerEndS2S3: CGFloat = 0.03

    @State var rotationDegreeS1 = initialDegree
    @State var rotationDegreeS2 = initialDegree
    @State var rotationDegreeS3 = initialDegree

    private let quotes = [
        "La langue des signes est une langue complète et expressive.",
        "La langue des signes n'est pas universelle, chaque pays a sa propre langue des signes, avec sa propre grammaire et son propre vocabulaire.",
        "La langue des signes américaine (ASL) est différente de la langue des signes britannique (BSL), même si les deux pays partagent la même langue parlée.",
        "La langue des signes est une langue visuelle et spatiale, elle utilise les mouvements des mains, les expressions faciales et la posture du corps pour communiquer.",
        "La langue des signes a été reconnue comme une langue officielle aux États-Unis en 1965.",
        "La langue des signes française (LSF) a été développée au 18ème siècle par l'abbé Charles-Michel de l'Épée.",
        "La langue des signes n'est pas un code pour la langue parlée, c'est une langue à part entière avec sa propre grammaire et sa propre syntaxe.",
        "La langue des signes est utilisée par les sourds, mais aussi par les malentendants et les entendants, y compris les bébés et les jeunes enfants.",
        "La langue des signes peut être utilisée pour raconter des histoires, faire de la poésie et même chanter.",
        "La langue des signes internationale (IS) est utilisée pour la communication internationale, mais elle n'est pas une langue maternelle pour quiconque.",
        "La langue des signes a été utilisée pour la première fois à la télévision aux États-Unis en 1970, dans l'émission Sesame Street.",
        "La langue des signes a son propre alphabet, appelé l'alphabet manuel ou dactylologique.",
        "La langue des signes peut être utilisée pour communiquer avec les animaux, comme les gorilles et les chimpanzés.",
        "La langue des signes a été utilisée pour la première fois dans l'éducation des sourds en Espagne au 16ème siècle.",
        "La langue des signes peut être utilisée pour communiquer sous l'eau, dans des environnements bruyants ou lorsque la parole est impossible.",
        "La langue des signes a été interdite dans de nombreuses écoles pour sourds au 19ème siècle, en faveur de l'oralisme.",
        "La langue des signes a été reconnue comme une langue à part entière par l'Organisation des Nations Unies en 1991.",
        "La langue des signes peut être utilisée pour exprimer des émotions et des nuances subtiles, grâce à l'utilisation des expressions faciales et de la posture du corps.",
        "La langue des signes a été utilisée pour la première fois dans un film en 1927, dans le film américain 'The Jazz Singer'.",
        "La langue des signes peut être utilisée pour communiquer avec des personnes qui ne parlent pas la même langue, en utilisant la langue des signes internationale.",
"La langue des signes est enseignée dans de nombreuses écoles et universités à travers le monde, comme une langue étrangère."
    ]

var body: some View {
    ZStack {


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
