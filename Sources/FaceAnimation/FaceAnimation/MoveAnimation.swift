//
//  MoveAnimation.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/8/23.
//

import Foundation

public protocol MoveAnimation: FacialFeatureAnimation {
    var moveToPosition: CGPoint { get }
}
