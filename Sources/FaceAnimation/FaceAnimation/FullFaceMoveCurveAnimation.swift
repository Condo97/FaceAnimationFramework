//
//  FullFaceMoveCurveAnimation.swift
//  
//
//  Created by Alex Coundouriotis on 9/11/23.
//

import Foundation

fileprivate struct MoveCurve: MoveCurveAnimation {
    var moveToQuadCurvePoint: CGPoint
    var moveToQuadCurveControlPoint: CGPoint
}

public protocol FullFaceMoveCurveAnimation: FaceAnimation {
    
    var moveToQuadCurvePoint: CGPoint { get set }
    var moveToQuadCurveControlPoint: CGPoint { get set }
    
}

extension FullFaceMoveCurveAnimation {
    
    var eyebrowsAnimation: FacialFeatureAnimation? {
        MoveCurve(moveToQuadCurvePoint: moveToQuadCurvePoint, moveToQuadCurveControlPoint: moveToQuadCurveControlPoint)
    }
    
    var eyesAnimation: FacialFeatureAnimation? {
        MoveCurve(moveToQuadCurvePoint: moveToQuadCurvePoint, moveToQuadCurveControlPoint: moveToQuadCurveControlPoint)
    }
    
    var noseAnimation: FacialFeatureAnimation? {
        let newMoveToQuadCurvePoint = CGPoint(x: moveToQuadCurvePoint.x / 2, y: moveToQuadCurvePoint.y / 2)
        let newMoveToQuadCurveControlPoint = CGPoint(x: moveToQuadCurveControlPoint.x / 2, y: moveToQuadCurveControlPoint.y / 2)
        return MoveCurve(moveToQuadCurvePoint: newMoveToQuadCurvePoint, moveToQuadCurveControlPoint: newMoveToQuadCurveControlPoint)
    }
    
    var mouthAnimation: FacialFeatureAnimation? {
        let newMoveToQuadCurvePoint = CGPoint(x: moveToQuadCurvePoint.x / 2, y: moveToQuadCurvePoint.y / 2)
        let newMoveToQuadCurveControlPoint = CGPoint(x: moveToQuadCurveControlPoint.x / 2, y: moveToQuadCurveControlPoint.y / 2)
        return MoveCurve(moveToQuadCurvePoint: newMoveToQuadCurvePoint, moveToQuadCurveControlPoint: newMoveToQuadCurveControlPoint)
    }
    
    var backgroundAnimation: FacialFeatureAnimation? {
        let newMoveToQuadCurvePoint = CGPoint(x: moveToQuadCurvePoint.x / 4, y: moveToQuadCurvePoint.y / 4)
        let newMoveToQuadCurveControlPoint = CGPoint(x: moveToQuadCurveControlPoint.x / 4, y: moveToQuadCurveControlPoint.y / 4)
        return MoveCurve(moveToQuadCurvePoint: newMoveToQuadCurvePoint, moveToQuadCurveControlPoint: newMoveToQuadCurveControlPoint)
    }
    
}
