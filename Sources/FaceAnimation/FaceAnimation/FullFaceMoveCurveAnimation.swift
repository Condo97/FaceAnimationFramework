////
////  FullFaceMoveCurveAnimation.swift
////  
////
////  Created by Alex Coundouriotis on 9/11/23.
////
//
//import Foundation
//
//fileprivate struct MoveCurve: MoveCurveAnimation {
//    var moveToQuadCurvePoint: CGPoint
//    var moveToQuadCurveControlPoint: CGPoint
//}
//
//public protocol FullFaceMoveCurveAnimation: FaceAnimation {
//    
//    var moveToQuadCurvePoint: CGPoint { get }
//    var moveToQuadCurveControlPoint: CGPoint { get }
//    
//}
//
//public extension FullFaceMoveCurveAnimation {
//    
//    var eyebrowsAnimation: FacialFeatureAnimationType? {
//        .curve(MoveCurve(moveToQuadCurvePoint: moveToQuadCurvePoint, moveToQuadCurveControlPoint: moveToQuadCurveControlPoint))
//    }
//    
//    var eyesAnimation: FacialFeatureAnimationType? {
//        .curve(MoveCurve(moveToQuadCurvePoint: moveToQuadCurvePoint, moveToQuadCurveControlPoint: moveToQuadCurveControlPoint))
//    }
//    
//    var noseAnimation: FacialFeatureAnimationType? {
//        let newMoveToQuadCurvePoint = CGPoint(x: moveToQuadCurvePoint.x / 2, y: moveToQuadCurvePoint.y / 2)
//        let newMoveToQuadCurveControlPoint = CGPoint(x: moveToQuadCurveControlPoint.x / 2, y: moveToQuadCurveControlPoint.y / 2)
//        return .curve(MoveCurve(moveToQuadCurvePoint: newMoveToQuadCurvePoint, moveToQuadCurveControlPoint: newMoveToQuadCurveControlPoint))
//    }
//    
//    var mouthAnimation: FacialFeatureAnimationType? {
//        let newMoveToQuadCurvePoint = CGPoint(x: moveToQuadCurvePoint.x / 2, y: moveToQuadCurvePoint.y / 2)
//        let newMoveToQuadCurveControlPoint = CGPoint(x: moveToQuadCurveControlPoint.x / 2, y: moveToQuadCurveControlPoint.y / 2)
//        return .curve(MoveCurve(moveToQuadCurvePoint: newMoveToQuadCurvePoint, moveToQuadCurveControlPoint: newMoveToQuadCurveControlPoint))
//    }
//    
//    var backgroundAnimation: FacialFeatureAnimationType? {
//        let newMoveToQuadCurvePoint = CGPoint(x: moveToQuadCurvePoint.x / 4, y: moveToQuadCurvePoint.y / 4)
//        let newMoveToQuadCurveControlPoint = CGPoint(x: moveToQuadCurveControlPoint.x / 4, y: moveToQuadCurveControlPoint.y / 4)
//        return .curve(MoveCurve(moveToQuadCurvePoint: newMoveToQuadCurvePoint, moveToQuadCurveControlPoint: newMoveToQuadCurveControlPoint))
//    }
//    
//}
