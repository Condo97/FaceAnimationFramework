//
//  SwiftUIView.swift
//  
//
//  Created by Alex Coundouriotis on 10/26/23.
//

import SwiftUI

struct SwiftUIView: UIViewRepresentable {
    
    @State var frame: CGRect
    @State var faceImageName: String
    @State var startAnimation: FaceAnimation?
    
    func makeUIView(context: Context) -> FaceAnimationView {
        FaceAnimationView(
            frame: frame,
            faceImageName: faceImageName,
            startAnimation: startAnimation)
    }
    
    func updateUIView(_ uiView: FaceAnimationView, context: Context) {
        uiView.frame = frame
    }
    
}

//#Preview {
//    ZStack {
//        SwiftUIView(
//            frame: CGRect(x: 0, y: 0, width: 200, height: 200),
//            faceImageName: "face_background.png",
//            startAnimation: CenterFaceAnimation(duration: 0.0)
//        )
//    }
//}
