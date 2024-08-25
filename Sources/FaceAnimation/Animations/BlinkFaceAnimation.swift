//
//  BlinkFaceAnimation.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/9/23.
//

import Foundation

public struct BlinkFaceAnimation: FaceAnimation {
    public struct EyesAnimation: BlinkAnimation {
        public var blinkMinXScale: CGFloat?
        public var blinkMinYScale: CGFloat?
    }
    
    public var eyebrowsAnimation: FacialFeatureAnimationType?
    public var eyesAnimation: FacialFeatureAnimationType? = .blink(EyesAnimation())
    public var noseAnimation: FacialFeatureAnimationType?
    public var mouthAnimation: FacialFeatureAnimationType?
    public var backgroundAnimation: FacialFeatureAnimationType?
    
    public var duration: CFTimeInterval = 0.2
    
    public init() {
        
    }
}
