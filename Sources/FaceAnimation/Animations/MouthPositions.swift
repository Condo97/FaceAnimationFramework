//
//  MouthPositions.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/8/23.
//

import Foundation

public enum MouthPositions: LineAnimation {
    
    case smile
    case neutral
    case thinking
    case frown
    
    public var linePosition: CGPoint {
        switch(self) {
        case .smile: return CGPoint(x: 114, y: 224)
        case .neutral: return CGPoint(x: 122, y: 228)
        case .frown: return CGPoint(x: 118, y: 228)
        case .thinking: return CGPoint(x: 124, y: 226)
        }
    }
    
    public var quadCurvePoint: CGPoint {
        switch(self) {
        case .smile: return CGPoint(x: 186, y: 224)
        case .neutral: return CGPoint(x: 178, y: 228)
        case .frown: return CGPoint(x: 182, y: 228)
        case .thinking: return CGPoint(x: 176, y: 226)
        }
    }
    
    public var quadCurveControlPoint: CGPoint {
        switch(self) {
        case .smile: return CGPoint(x: 150, y: 232)
        case .neutral: return CGPoint(x: 150, y: 232)
        case .frown: return CGPoint(x: 150, y: 230)
        case .thinking: return CGPoint(x: 170, y: 224)
        }
    }
}
