//
//  FacialFeatureAnimationType.swift
//
//
//  Created by Alex Coundouriotis on 8/25/24.
//

import Foundation

public enum FacialFeatureAnimationType: Equatable {
    case curve(MoveCurveAnimation)
    case blink(BlinkAnimation)
    case linear(MoveAnimation)
    case opacity(OpacityAnimation)
}
