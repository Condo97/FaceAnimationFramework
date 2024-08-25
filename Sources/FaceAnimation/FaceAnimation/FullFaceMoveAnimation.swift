//
//  FullFaceMoveAnimation.swift
//
//
//  Created by Alex Coundouriotis on 9/11/23.
//

import Foundation

fileprivate struct Move: MoveAnimation {
    var moveToPosition: CGPoint
}

public protocol FullFaceMoveAnimation: FaceAnimation {
    
    var moveToPosition: CGPoint { get }
    
}

public extension FullFaceMoveAnimation {
    
    var eyebrowsAnimation: FacialFeatureAnimationType? {
        .linear(Move(moveToPosition: moveToPosition))
    }
    
    var eyesAnimation: FacialFeatureAnimationType? {
        .linear(Move(moveToPosition: moveToPosition))
    }
    
    var noseAnimation: FacialFeatureAnimationType? {
        let newMoveToPosition = CGPoint(x: moveToPosition.x / 2, y: moveToPosition.y / 2)
        return .linear(Move(moveToPosition: newMoveToPosition))
    }
    
    var mouthAnimation: FacialFeatureAnimationType? {
        let newMoveToPosition = CGPoint(x: moveToPosition.x / 4, y: moveToPosition.y / 4)
        return .linear(Move(moveToPosition: newMoveToPosition))
    }
    
    var backgroundAnimation: FacialFeatureAnimationType? {
        let newMoveToPosition = CGPoint(x: moveToPosition.x / 4, y: moveToPosition.y / 4)
        return .linear(Move(moveToPosition: newMoveToPosition))
    }
    
}
