//
//  WaitAnimation.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/9/23.
//

import Foundation

public struct WaitFaceAnimation: FaceAnimation {
    public var eyebrowsAnimation: FacialFeatureAnimation?
    public var eyebrowsPosition: EyebrowsPositions?
    public var eyesAnimation: FacialFeatureAnimation?
    public var noseAnimation: FacialFeatureAnimation?
    public var mouthAnimation: FacialFeatureAnimation?
    public var mouthPosition: MouthPositions?
    public var backgroundAnimation: FacialFeatureAnimation?
    
    public var duration: CFTimeInterval
    
    init(duration: CFTimeInterval) {
        self.duration = duration
    }
}
