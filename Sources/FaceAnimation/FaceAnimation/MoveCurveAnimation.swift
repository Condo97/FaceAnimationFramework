//
//  MoveCurveAnimatin.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/8/23.
//

import Foundation

public struct MoveCurveAnimation: Equatable {
    public var moveToQuadCurvePoint: CGPoint
    public var moveToQuadCurveControlPoint: CGPoint
    
    public init(moveToQuadCurvePoint: CGPoint, moveToQuadCurveControlPoint: CGPoint) {
        self.moveToQuadCurvePoint = moveToQuadCurvePoint
        self.moveToQuadCurveControlPoint = moveToQuadCurveControlPoint
    }
}
