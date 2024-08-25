//
//  FullFaceMoveAnimation.swift
//
//
//  Created by Alex Coundouriotis on 9/11/23.
//

import Foundation

public extension FaceAnimation {
    
    static func fullFaceAnimation(withLinearAnimation moveAnimation: MoveAnimation, duration: CFTimeInterval) -> FaceAnimation {
        FaceAnimation(
            eyebrowsAnimation: .linear(moveAnimation),
            eyesAnimation: .linear(moveAnimation),
            noseAnimation: .linear(MoveAnimation(moveToPosition: CGPoint(x: moveAnimation.moveToPosition.x / 2, y: moveAnimation.moveToPosition.y / 2))),
            mouthAnimation: .linear(MoveAnimation(moveToPosition: CGPoint(x: moveAnimation.moveToPosition.x / 4, y: moveAnimation.moveToPosition.y / 4))),
            backgroundAnimation: .linear(MoveAnimation(moveToPosition: CGPoint(x: moveAnimation.moveToPosition.x / 4, y: moveAnimation.moveToPosition.y / 4))),
            duration: duration)
    }
    
    static func fullFaceAnimation(withCurveAnimation curveAnimation: MoveCurveAnimation, duration: CFTimeInterval) -> FaceAnimation {
        FaceAnimation(
            eyebrowsAnimation: .curve(curveAnimation),
            eyesAnimation: .curve(curveAnimation),
            noseAnimation: .curve(MoveCurveAnimation(
                moveToQuadCurvePoint: CGPoint(x: curveAnimation.moveToQuadCurvePoint.x / 2, y: curveAnimation.moveToQuadCurvePoint.y / 2),
                moveToQuadCurveControlPoint: CGPoint(x: curveAnimation.moveToQuadCurveControlPoint.x / 2, y: curveAnimation.moveToQuadCurveControlPoint.y / 2))),
            mouthAnimation: .curve(MoveCurveAnimation(
                moveToQuadCurvePoint: CGPoint(x: curveAnimation.moveToQuadCurvePoint.x / 2, y: curveAnimation.moveToQuadCurvePoint.y / 2),
                moveToQuadCurveControlPoint: CGPoint(x: curveAnimation.moveToQuadCurveControlPoint.x / 2, y: curveAnimation.moveToQuadCurveControlPoint.y / 2))),
            backgroundAnimation: .curve(MoveCurveAnimation(
                moveToQuadCurvePoint: CGPoint(x: curveAnimation.moveToQuadCurvePoint.x / 4, y: curveAnimation.moveToQuadCurvePoint.y / 4),
                moveToQuadCurveControlPoint: CGPoint(x: curveAnimation.moveToQuadCurveControlPoint.x / 4, y: curveAnimation.moveToQuadCurveControlPoint.y / 4))),
            duration: duration)
    }
    
//    var eyebrowsAnimation: FacialFeatureAnimationType? {
//        .linear(MoveAnimation(moveToPosition: moveToPosition))
//    }
//    
//    var eyesAnimation: FacialFeatureAnimationType? {
//        .linear(MoveAnimation(moveToPosition: moveToPosition))
//    }
//    
//    var noseAnimation: FacialFeatureAnimationType? {
//        let newMoveToPosition = CGPoint(x: moveToPosition.x / 2, y: moveToPosition.y / 2)
//        return .linear(MoveAnimation(moveToPosition: newMoveToPosition))
//    }
//    
//    var mouthAnimation: FacialFeatureAnimationType? {
//        let newMoveToPosition = CGPoint(x: moveToPosition.x / 4, y: moveToPosition.y / 4)
//        return .linear(MoveAnimation(moveToPosition: newMoveToPosition))
//    }
//    
//    var backgroundAnimation: FacialFeatureAnimationType? {
//        let newMoveToPosition = CGPoint(x: moveToPosition.x / 4, y: moveToPosition.y / 4)
//        return .linear(MoveAnimation(moveToPosition: newMoveToPosition))
//    }
    
}
