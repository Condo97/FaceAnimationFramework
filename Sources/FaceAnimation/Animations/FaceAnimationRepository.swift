//
//  FaceAnimationRepository.swift.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/9/23.
//

import Foundation

public struct FaceAnimationRepository {
    
}

extension FaceAnimationRepository {
    
    public static var blinkFaceAnimation: FaceAnimation {
        FaceAnimation(
            eyesAnimation: .blink(BlinkAnimation()),
            duration: 0.2)
    }
    
    public static func centerFaceAnimation(duration: CFTimeInterval) -> FaceAnimation {
        FaceAnimation.fullFaceAnimation(
            withLinearAnimation: zeroPositionMoveAnimation,
            duration: duration)
    }
    
    public static func waitAnimation(duration: CFTimeInterval) -> FaceAnimation {
        FaceAnimation(duration: duration)
    }
    
    
    public static let zeroPositionMoveAnimation = MoveAnimation(moveToPosition: CGPoint(x: 0, y: 0))
    
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
