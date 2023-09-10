//
//  BlinkAnimation.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/9/23.
//

import Foundation

public protocol BlinkAnimation: FacialFeatureAnimation {
    var blinkMinXScale: CGFloat? { get }
    var blinkMinYScale: CGFloat? { get }
}
