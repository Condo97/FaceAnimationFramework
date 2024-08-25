//
//  FaceAnimation.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/8/23.
//

import Foundation

public struct FaceAnimation: Equatable {
    var eyebrowsAnimation: FacialFeatureAnimationType?
    var eyesAnimation: FacialFeatureAnimationType?
    var noseAnimation: FacialFeatureAnimationType?
    var mouthAnimation: FacialFeatureAnimationType?
    var backgroundAnimation: FacialFeatureAnimationType?
    
    var duration: CFTimeInterval
}
