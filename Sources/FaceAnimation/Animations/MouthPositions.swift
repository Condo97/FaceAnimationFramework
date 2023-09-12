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
    
    public func getLinePosition(width: CGFloat, height: CGFloat) -> CGPoint {
        switch(self) {
        case .smile: return CGPoint(x: width * 19 / 50, y: height * 56 / 75)
        case .neutral: return CGPoint(x: width * 61 / 150, y: height * 19 / 25)
        case .frown: return CGPoint(x: width * 59 / 150, y: height * 19 / 25)
        case .thinking: return CGPoint(x: width * 31 / 75, y: height * 113 / 150)
        }
    }

    public func getQuadCurvePoint(width: CGFloat, height: CGFloat) -> CGPoint {
        switch(self) {
        case .smile: return CGPoint(x: width * 31 / 50, y: height * 56 / 75)
        case .neutral: return CGPoint(x: width * 89 / 150, y: height * 19 / 25)
        case .frown: return CGPoint(x: width * 91 / 150, y: height * 19 / 25)
        case .thinking: return CGPoint(x: width * 44 / 75, y: height * 113 / 150)
        }
    }

    public func getQuadCurveControlPoint(width: CGFloat, height: CGFloat) -> CGPoint {
        switch(self) {
        case .smile: return CGPoint(x: width * 1 / 2, y: height * 19 / 25)
        case .neutral: return CGPoint(x: width * 1 / 2, y: height * 58 / 75)
        case .frown: return CGPoint(x: width * 1 / 2, y: height * 23 / 30)
        case .thinking: return CGPoint(x: width * 17 / 30, y: height * 56 / 75)
        }
    }
}
