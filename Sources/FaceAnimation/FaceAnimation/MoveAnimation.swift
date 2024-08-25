//
//  MoveAnimation.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/8/23.
//

import Foundation

public struct MoveAnimation: Equatable {
    public var moveToPosition: CGPoint
    
    public init(moveToPosition: CGPoint) {
        self.moveToPosition = moveToPosition
    }
}
