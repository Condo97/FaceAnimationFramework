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
}
