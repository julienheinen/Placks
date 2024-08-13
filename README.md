![Logo](https://github.com/julienheinen/Placks/blob/main/Placks/Assets.xcassets/AppIcon.appiconset/Icon-180.png?raw=true)
# Placks - Connecting Hands, Breaking Barriers
![image](https://img.shields.io/badge/TensorFlow-FF6F00?style=for-the-badge&logo=tensorflow&logoColor=white) 
![image](https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white) 
![image](https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white)

Placks is an application created in SwiftUI that allows for the recognition of sign language. It uses Core ML and over 30 TB of sign language data. It can transcribe sign language into text or speech. The application is currently in development and the AI requires a significant amount of resources for training.

## Features

- Sign language recognition using Core ML (in development)
- Transcription of sign language into text or speech (in development)
- Comprehension of multiple sign languages (LSF, LSFB, German, English, Chinese, Indian, etc.) (in development)
- Dictionary with videos and words transcribed in sign language and vice versa (in development)

## Installation

To install Placks, you will need to have Xcode and SwiftUI installed on your computer. You can then clone the repository and open the project in Xcode. Please note that the application is currently in development and may not be fully functional.

## Usage

To use Placks, simply open the application and select the sign language you want to use. You can then start signing in front of the camera and the application will transcribe the sign language into text or speech. You can also access the dictionary to learn new signs. Please note that the application is currently in development and may not be fully functional.

## Contributing

If you would like to contribute to Placks, please submit a pull request with your proposed changes. Please note that the application is currently in development and may not be fully functional.

## Credits

Placks was created by Julien Heinen.
thanks to @alexandre324 for his contribution to the project

## License

Placks is licensed under the MIT license. See the LICENSE file for more information.

## Code Example

Here is an example of the code used in the application:
```
struct Accueil: View {
    @Binding var selectedTab: String
    @Binding var darkmode: Bool

    //Hidding Tab Menu....
    init(darkmode: Binding<Bool>,selectedTab: Binding<String>) {self._selectedTab = selectedTab
        self._darkmode = darkmode
        UITabBar.appearance().isHidden = true
    }
    var body: some View {

        //Tab View with Tabs...
        TabView(selection: $selectedTab ){

            //Views...
            PageAccueil(colorBackground: darkmode ? BackgroundColor:.white, colorTextFriends: darkmode ? .white:.black, colorBackgroundHeader: darkmode ? BackgroundColorHeader : .white, colorTextHeader: darkmode ? .white:.purple, opacityImages: darkmode ? 0.7 : 1, backgroundColorFriendStrip: darkmode ? BackgroundColorHeader : lightGray)
                .tag("Accueil")

            Historique(BackrgoundColor: darkmode ? .black: .white)
                .tag("Historique")

            Paramètres(darkmode: darkmode, backgroundColor: darkmode ? BackgroundColor:.white)
                .tag("Paramètres")

            Aide()
                .tag("Aide")
            Notifications()
                .tag("Notifications")
        }
    }
}
```
This code creates a tab view with different tabs for the different sections of the application (Accueil, Historique, Paramètres, Aide, Notifications). The selected tab is stored in the `selectedTab` variable, and the `darkmode` variable is used to determine the color scheme of the application. The `UITabBar` is hidden to create a custom tab bar.

Please note that the application is currently in development and may not be fully functional. The AI requires a significant amount of resources for training and may not be fully accurate. We appreciate your patience and understanding as we continue to develop Placks.
