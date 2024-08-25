//
//  BlinkFaceAnimation.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/9/23.
//

import Foundation

struct FaceAnimationRepository {
    
    let blinkFaceAnimation = FaceAnimation(
        eyesAnimation: .blink(BlinkAnimation()),
        duration: 0.2)
    
    func centerFaceAnimation(duration: CFTimeInterval) -> FaceAnimation {
        FaceAnimation(
            eyebrowsAnimation: .linear(FaceAnimationRepository.zeroPositionMoveAnimation),
            eyesAnimation: .linear(FaceAnimationRepository.zeroPositionMoveAnimation),
            noseAnimation: .linear(FaceAnimationRepository.zeroPositionMoveAnimation),
            mouthAnimation: .linear(FaceAnimationRepository.zeroPositionMoveAnimation),
            backgroundAnimation: .linear(FaceAnimationRepository.zeroPositionMoveAnimation),
            duration: duration)
    }
    
    
    private static let zeroPositionMoveAnimation = MoveAnimation(moveToPosition: CGPoint(x: 0, y: 0))
    
}

//public struct BlinkFaceAnimation: FaceAnimation {
//    
////    public struct EyesAnimation: BlinkAnimation {
////        public var blinkMinXScale: CGFloat?
////        public var blinkMinYScale: CGFloat?
////    }
//    
//    public var eyebrowsAnimation: FacialFeatureAnimationType?
//    public var eyesAnimation: FacialFeatureAnimationType? = .blink(BlinkAnimation())
//    public var noseAnimation: FacialFeatureAnimationType?
//    public var mouthAnimation: FacialFeatureAnimationType?
//    public var backgroundAnimation: FacialFeatureAnimationType?
//    
//    public var duration: CFTimeInterval = 0.2
//    
//    public init() {
//        
//    }
//}
