////
////  FaceAnimationRepresentable.swift
////  
////
////  Created by Alex Coundouriotis on 10/26/23.
////
//
//import SwiftUI
//
//public struct FaceAnimationRepresentable: UIViewRepresentable {
//    
//    public var frame: CGRect
//    public var faceImageName: String
//    public var color: UIColor
//    public var startAnimation: FaceAnimation?
//    
//    public init(frame: CGRect, faceImageName: String, color: UIColor, startAnimation: FaceAnimation? = nil) {
//        self.frame = frame
//        self.faceImageName = faceImageName
//        self.color = color
//        self.startAnimation = startAnimation
//    }
//    
//    public func makeUIView(context: Context) -> FaceAnimationView {
//        let faceAnimationView = FaceAnimationView(
//            frame: frame,
//            faceImageName: faceImageName,
//            startAnimation: startAnimation)
//        
//        faceAnimationView.tintColor = color
//        
//        return faceAnimationView
//    }
//    
//    public func updateUIView(_ uiView: FaceAnimationView, context: Context) {
//        uiView.frame = frame
//    }
//    
//}
//
////#Preview {
////    ZStack {
////        FaceAnimationRepresentable(
////            frame: CGRect(x: 0, y: 0, width: 200, height: 200),
////            faceImageName: "face_background.png",
////            startAnimation: CenterFaceAnimation(duration: 0.0)
////        )
////    }
////}
