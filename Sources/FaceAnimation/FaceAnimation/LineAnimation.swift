//
//  LineAnimation.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/8/23.
//

import Foundation

public protocol LineAnimation: FacialFeatureAnimation {
    var linePosition: CGPoint { get }
    var quadCurvePoint: CGPoint { get }
    var quadCurveControlPoint: CGPoint { get }
}
