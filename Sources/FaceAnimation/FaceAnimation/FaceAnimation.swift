//
//  FaceAnimation.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/8/23.
//

import Foundation

public struct FaceAnimation: Equatable {
    public var eyebrowsAnimation: FacialFeatureAnimationType?
    public var eyesAnimation: FacialFeatureAnimationType?
    public var noseAnimation: FacialFeatureAnimationType?
    public var mouthAnimation: FacialFeatureAnimationType?
    public var backgroundAnimation: FacialFeatureAnimationType?
    
    public var duration: CFTimeInterval
    
    public init(eyebrowsAnimation: FacialFeatureAnimationType? = nil, eyesAnimation: FacialFeatureAnimationType? = nil, noseAnimation: FacialFeatureAnimationType? = nil, mouthAnimation: FacialFeatureAnimationType? = nil, backgroundAnimation: FacialFeatureAnimationType? = nil, duration: CFTimeInterval) {
        self.eyebrowsAnimation = eyebrowsAnimation
        self.eyesAnimation = eyesAnimation
        self.noseAnimation = noseAnimation
        self.mouthAnimation = mouthAnimation
        self.backgroundAnimation = backgroundAnimation
        self.duration = duration
    }
}
