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
    
    public var eyebrowsAnimation: FacialFeatureAnimation? = ZeroPositionMoveAnimation()
    public var eyebrowsPosition: EyebrowsPositions? = .dismissed
    public var eyesAnimation: FacialFeatureAnimation? = ZeroPositionMoveAnimation()
    public var noseAnimation: FacialFeatureAnimation? = ZeroPositionMoveAnimation()
    public var mouthAnimation: FacialFeatureAnimation? = ZeroPositionMoveAnimation()
    public var mouthPosition: MouthPositions? = .neutral
    public var backgroundAnimation: FacialFeatureAnimation? = ZeroPositionMoveAnimation()
    
    public var duration: CFTimeInterval
    
    public init(duration: CFTimeInterval) {
        self.duration = duration
    }
}
