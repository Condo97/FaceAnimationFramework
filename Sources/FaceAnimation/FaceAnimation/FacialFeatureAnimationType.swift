//
//  FacialFeatureAnimationType.swift
//
//
//  Created by Alex Coundouriotis on 8/25/24.
//

import Foundation

public enum FacialFeatureAnimationType {
    case curve(any MoveCurveAnimation)
    case blink(any BlinkAnimation)
    case linear(any MoveAnimation)
    case opacity(any OpacityAnimation)
}
