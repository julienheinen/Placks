//  CameraView.swift
//  Placks
//
//  Created by Julien Heinen on 02/06/2021.
//

import SwiftUI

struct CameraView: View {
    
    @State private var isShowPhotoLibrary = false
        @State private var image = UIImage()
        
        var body: some View {
            VStack {
                
                Image(uiImage: self.image)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                Button(action: {
                    self.isShowPhotoLibrary = true
                }) {
                    HStack {
                        Image(systemName: "photo")
                            .font(.system(size: 20))
                            
                        Text("Photo library")
                            .font(.headline)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                }
            }
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
            }
        }
    }
        
        
    





struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
        }
}
