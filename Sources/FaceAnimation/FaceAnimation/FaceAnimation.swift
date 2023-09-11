//
//  FaceAnimation.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/8/23.
//

import Foundation

public protocol FaceAnimation {
    var eyebrowsAnimation: FacialFeatureAnimation? { get }
    var eyebrowsPosition: EyebrowsPositions? { get }
    var eyesAnimation: FacialFeatureAnimation? { get }
    var noseAnimation: FacialFeatureAnimation? { get }
    var mouthAnimation: FacialFeatureAnimation? { get }
    var mouthPosition: MouthPositions? { get }
    var backgroundAnimation: FacialFeatureAnimation? { get }
    
    var duration: CFTimeInterval { get }
}
