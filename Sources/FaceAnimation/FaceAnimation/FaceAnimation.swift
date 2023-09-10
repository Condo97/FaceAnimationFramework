//
//  FaceAnimation.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/8/23.
//

import Foundation

public protocol FaceAnimation {
    var eyebrowsAnimation: FacialFeatureAnimation? { get set }
    var eyebrowsPosition: EyebrowsPositions? { get set }
    var eyesAnimation: FacialFeatureAnimation? { get set }
    var noseAnimation: FacialFeatureAnimation? { get set }
    var mouthAnimation: FacialFeatureAnimation? { get set }
    var mouthPosition: MouthPositions? { get set }
    var backgroundAnimation: FacialFeatureAnimation? { get set }
    
    var duration: CFTimeInterval { get set }
}
