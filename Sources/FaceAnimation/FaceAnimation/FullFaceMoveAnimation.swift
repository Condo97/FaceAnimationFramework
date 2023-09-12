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
    
    var eyebrowsAnimation: FacialFeatureAnimation? {
        Move(moveToPosition: moveToPosition)
    }
    
    var eyesAnimation: FacialFeatureAnimation? {
        Move(moveToPosition: moveToPosition)
    }
    
    var noseAnimation: FacialFeatureAnimation? {
        let newMoveToPosition = CGPoint(x: moveToPosition.x / 2, y: moveToPosition.y / 2)
        return Move(moveToPosition: newMoveToPosition)
    }
    
    var mouthAnimation: FacialFeatureAnimation? {
        let newMoveToPosition = CGPoint(x: moveToPosition.x / 4, y: moveToPosition.y / 4)
        return Move(moveToPosition: newMoveToPosition)
    }
    
    var backgroundAnimation: FacialFeatureAnimation? {
        let newMoveToPosition = CGPoint(x: moveToPosition.x / 4, y: moveToPosition.y / 4)
        return Move(moveToPosition: newMoveToPosition)
    }
    
}
