//
//  EyebrowsPositions.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/9/23.
//

import Foundation

public enum EyebrowsPositions {
    
    case dismissed
    case rightRaised
    case leftRaised
    case lowered
    
    private static let loweredEyebrowPosition = CGPoint(x: 0, y: 0)
    private static let raisedEyebrowPosition = CGPoint(x: 0, y: -15)
    
    public var opacity: Float {
        if self == .dismissed {
            return 0.0
        }
        
        return 1.0
    }
    
    public var leftEyebrowPosition: CGPoint {
        switch(self) {
        case .dismissed:
            return EyebrowsPositions.raisedEyebrowPosition
        case .rightRaised:
            return EyebrowsPositions.loweredEyebrowPosition
        case .leftRaised:
            return EyebrowsPositions.raisedEyebrowPosition
        case .lowered:
            return EyebrowsPositions.loweredEyebrowPosition
        }
    }
    
    public var rightEyebrowPosition: CGPoint {
        switch(self) {
        case .dismissed:
            return EyebrowsPositions.raisedEyebrowPosition
        case .rightRaised:
            return EyebrowsPositions.raisedEyebrowPosition
        case .leftRaised:
            return EyebrowsPositions.loweredEyebrowPosition
        case .lowered:
            return EyebrowsPositions.loweredEyebrowPosition
        }
    }
    
    public func getLeftEyebrowAnimation() -> MoveAnimation & OpacityAnimation {
        getEyebrowAnimation(eyebrowsPosition: self.leftEyebrowPosition, targetOpacity: self.opacity)
    }
    
    public func getRightEyebrowAnimation() -> MoveAnimation & OpacityAnimation {
        getEyebrowAnimation(eyebrowsPosition: self.rightEyebrowPosition, targetOpacity: self.opacity)
    }
    
    private func getEyebrowAnimation(eyebrowsPosition: CGPoint, targetOpacity: Float) -> MoveAnimation & OpacityAnimation {
        struct EyebrowMoveAnimation: MoveAnimation, OpacityAnimation {
            var moveToPosition: CGPoint
            var targetOpacity: Float
        }
        
        return EyebrowMoveAnimation(moveToPosition: eyebrowsPosition, targetOpacity: targetOpacity)
    }
    
}
