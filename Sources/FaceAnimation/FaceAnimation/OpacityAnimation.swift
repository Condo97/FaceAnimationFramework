//
//  OpacityAnimation.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/9/23.
//

import Foundation

public struct OpacityAnimation: Equatable {
    var targetOpacity: Float
    
    public init(targetOpacity: Float) {
        self.targetOpacity = targetOpacity
    }
}
