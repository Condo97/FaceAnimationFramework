//
//  WaitAnimation.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/9/23.
//

import Foundation

public struct WaitFaceAnimation: FaceAnimation {
    public var eyebrowsAnimation: FacialFeatureAnimationType?
    public var eyesAnimation: FacialFeatureAnimationType?
    public var noseAnimation: FacialFeatureAnimationType?
    public var mouthAnimation: FacialFeatureAnimationType?
    public var backgroundAnimation: FacialFeatureAnimationType?
    
    public var duration: CFTimeInterval
    
    public init(duration: CFTimeInterval) {
        self.duration = duration
    }
}
