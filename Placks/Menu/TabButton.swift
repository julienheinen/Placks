//
//  TabButton.swift
//  Placks
//
//  Created by Julien Heinen on 27/06/2021.
//

import SwiftUI

var tabBackground = Color(red: 20 / 255, green: 20 / 255, blue: 20 / 255)

struct TabButton: View {
    var image: String
    var title: String
    
    //Select Tab...
    @Binding var selectedTab: String
    @Binding var darkmode: Bool
    @Binding var showMenu: Bool

    
    // For Hero Animation Slide...
    var animation: Namespace.ID
    var body: some View {
        
        Button(action: {
            withAnimation(.spring()){selectedTab = title }
            withAnimation(.spring()){
                showMenu.toggle()}
        }, label: {
            
            TabButtons(colorTabBG: darkmode ? tabBackground : .white, colorTabTextSelected: darkmode ? .white : .blue, colorTabText: darkmode ? .gray : .white, imageTab: image, selectedTAB: selectedTab, theText: title, animation: animation)
            
        })
    }
}

//struct of the tab button
struct TabButtons: View{
    
    var colorTabBG : Color
    var colorTabTextSelected : Color
    var colorTabText : Color
    var imageTab : String
    var selectedTAB : String
    var theText: String
    var animation: Namespace.ID
    
    var body: some View{
        
        HStack(spacing : 15){
        
            Image(systemName: imageTab)
                .font(.title2)
                .frame(width: 30)
                
            
            Text(theText)
                .fontWeight(.bold)
        }
        .foregroundColor(selectedTAB == theText ? colorTabTextSelected : colorTabText)
        .padding(.vertical,12)
        .padding(.horizontal, 10)
        //Max Frame...
        .frame(maxWidth: getRect().width - 17, alignment: .leading)
        .background(
        
            // hero animation
            ZStack{
                
                if selectedTAB == theText{
                    colorTabBG
                        .opacity(selectedTAB == theText ? 1 : 0)
                        .clipShape(CustomCorners(corners: [.topRight,.bottomRight], radius: 12))
                        .matchedGeometryEffect(id: "TAB", in: animation)
                                    }
            }
        )
        
    }
}

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
