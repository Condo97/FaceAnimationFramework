//
//  LineAnimation.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/8/23.
//

import Foundation

public protocol LineAnimation: FacialFeatureAnimation {
    func getLinePosition(width: CGFloat, height: CGFloat) -> CGPoint
    func getQuadCurvePoint(width: CGFloat, height: CGFloat) -> CGPoint
    func getQuadCurveControlPoint(width: CGFloat, height: CGFloat) -> CGPoint
}
