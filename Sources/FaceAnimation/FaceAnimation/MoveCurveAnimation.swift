//
//  MoveCurveAnimatin.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/8/23.
//

import Foundation

protocol MoveCurveAnimation: FacialFeatureAnimation {
    var moveToQuadCurvePoint: CGPoint { get set }
    var moveToQuadCurveControlPoint: CGPoint { get set }
}
