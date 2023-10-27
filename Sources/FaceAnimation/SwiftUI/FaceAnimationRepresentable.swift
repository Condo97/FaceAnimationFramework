//
//  FaceAnimationRepresentable.swift
//  
//
//  Created by Alex Coundouriotis on 10/26/23.
//

import SwiftUI

public struct FaceAnimationRepresentable: UIViewRepresentable {
    
    @State public var frame: CGRect
    @State public var faceImageName: String
    @State public var startAnimation: FaceAnimation?
    
    public func makeUIView(context: Context) -> FaceAnimationView {
        FaceAnimationView(
            frame: frame,
            faceImageName: faceImageName,
            startAnimation: startAnimation)
    }
    
    public func updateUIView(_ uiView: FaceAnimationView, context: Context) {
        uiView.frame = frame
    }
    
}

//#Preview {
//    ZStack {
//        FaceAnimationRepresentable(
//            frame: CGRect(x: 0, y: 0, width: 200, height: 200),
//            faceImageName: "face_background.png",
//            startAnimation: CenterFaceAnimation(duration: 0.0)
//        )
//    }
//}
