//
//  BlinkFaceAnimation.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/9/23.
//

import Foundation

struct BlinkFaceAnimation: FaceAnimation {
    struct EyesAnimation: BlinkAnimation {
        var blinkMinXScale: CGFloat?
        var blinkMinYScale: CGFloat?
    }
    
    var eyebrowsAnimation: FacialFeatureAnimation?
    var eyebrowsPosition: EyebrowsPositions?
    var eyesAnimation: FacialFeatureAnimation? = EyesAnimation()
    var noseAnimation: FacialFeatureAnimation?
    var mouthAnimation: FacialFeatureAnimation?
    var mouthPosition: MouthPositions?
    var backgroundAnimation: FacialFeatureAnimation?
    
    var duration: CFTimeInterval = 0.2
}
