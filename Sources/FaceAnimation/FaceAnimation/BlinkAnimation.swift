//
//  BlinkAnimation.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/9/23.
//

import Foundation

public struct BlinkAnimation: Equatable {
    public var blinkMinXScale: CGFloat?
    public var blinkMinYScale: CGFloat?
    
    public init(blinkMinXScale: CGFloat? = nil, blinkMinYScale: CGFloat? = nil) {
        self.blinkMinXScale = blinkMinXScale
        self.blinkMinYScale = blinkMinYScale
    }
}
