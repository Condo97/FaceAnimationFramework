//
//  FaceAnimation.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/8/23.
//

import Foundation

public protocol FaceAnimation {
    var eyebrowsAnimation: FacialFeatureAnimationType? { get }
    var eyesAnimation: FacialFeatureAnimationType? { get }
    var noseAnimation: FacialFeatureAnimationType? { get }
    var mouthAnimation: FacialFeatureAnimationType? { get }
    var backgroundAnimation: FacialFeatureAnimationType? { get }
    
    var duration: CFTimeInterval { get }
}
