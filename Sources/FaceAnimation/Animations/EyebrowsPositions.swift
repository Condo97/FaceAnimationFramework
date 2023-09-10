//
//  EyebrowsPositions.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/9/23.
//

import Foundation

enum EyebrowsPositions {
    
    case dismissed
    case rightRaised
    case leftRaised
    case lowered
    
    private static let loweredEyebrowPosition = CGPoint(x: 0, y: 0)
    private static let raisedEyebrowPosition = CGPoint(x: 0, y: -40)
    
    var opacity: Float {
        if self == .dismissed {
            return 0.0
        }
        
        return 1.0
    }
    
    var leftEyebrowPosition: CGPoint {
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
    
    var rightEyebrowPosition: CGPoint {
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
    
    func getLeftEyebrowAnimation() -> MoveAnimation & OpacityAnimation {
        getEyebrowAnimation(eyebrowsPosition: self.leftEyebrowPosition, targetOpacity: self.opacity)
    }
    
    func getRightEyebrowAnimation() -> MoveAnimation & OpacityAnimation {
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
