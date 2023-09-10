//
//  BlinkAnimation.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/9/23.
//

import Foundation

protocol BlinkAnimation: FacialFeatureAnimation {
    var blinkMinXScale: CGFloat? { get }
    var blinkMinYScale: CGFloat? { get }
}
