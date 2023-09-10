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
    
    public var eyebrowsAnimation: FacialFeatureAnimation?
    public var eyebrowsPosition: EyebrowsPositions?
    public var eyesAnimation: FacialFeatureAnimation? = EyesAnimation()
    public var noseAnimation: FacialFeatureAnimation?
    public var mouthAnimation: FacialFeatureAnimation?
    public var mouthPosition: MouthPositions?
    public var backgroundAnimation: FacialFeatureAnimation?
    
    public var asdf: Int
    
    public var duration: CFTimeInterval = 0.2
}
