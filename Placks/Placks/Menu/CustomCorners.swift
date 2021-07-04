//
//  CustomCorners.swift
//  Placks
//
//  Created by Julien Heinen on 27/06/2021.
//

import SwiftUI

//Custom Corner Shapes...
struct CustomCorners: Shape {
    
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect:CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }

}

