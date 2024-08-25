//
//  File.swift
//  
//
//  Created by Alex Coundouriotis on 9/10/23.
//

import Foundation

public struct CenterFaceAnimation: FaceAnimation {
    public struct ZeroPositionMoveAnimation: MoveAnimation {
        public var moveToPosition: CGPoint = CGPoint(x: 0, y: 0)
    }
    
    public var eyebrowsAnimation: FacialFeatureAnimationType? = .linear(ZeroPositionMoveAnimation())
    public var eyesAnimation: FacialFeatureAnimationType? = .linear(ZeroPositionMoveAnimation())
    public var noseAnimation: FacialFeatureAnimationType? = .linear(ZeroPositionMoveAnimation())
    public var mouthAnimation: FacialFeatureAnimationType? = .linear(ZeroPositionMoveAnimation())
    public var backgroundAnimation: FacialFeatureAnimationType? = .linear(ZeroPositionMoveAnimation())
    
    public var duration: CFTimeInterval
    
    public init(duration: CFTimeInterval) {
        self.duration = duration
    }
}
