//
//  FaceAnimationView.swift
//  FaceAnimationTest
//
//  Created by Alex Coundouriotis on 9/9/23.
//

import Foundation
import UIKit

open class FaceAnimationView: UIView {
    
    public var faceImageName: String?
    
    private let DEFAULT_BLINK_MIN_X_SCALE = 0.8
    private let DEFAULT_BLINK_MIN_Y_SCALE = 0.2
    
    private var fullFaceLayer: CALayer!
    
    private var leftEyebrowShapeLayer: CAShapeLayer!
    private var rightEyebrowShapeLayer: CAShapeLayer!
    private var eyebrowsLayer: CALayer!
    
    private var leftEyeShapeLayer: CAShapeLayer!
    private var rightEyeShapeLayer: CAShapeLayer!
    private var eyesLayer: CALayer!
    
    private var originalNosePath: UIBezierPath!
    private var noseShapeLayer: CAShapeLayer!
    
    private var originalMouthPath: UIBezierPath!
    private var mouthShapeLayer: CAShapeLayer!
    
    private var backgroundFaceLayer: CALayer!
    private var backgroundFaceImage: UIImage!
    
    private var animationsQueue: DispatchQueue = DispatchQueue(label: "animationsQueue")
    private var animationGroup: DispatchGroup = DispatchGroup()
    
    private var shouldEmptyQueue = false
    private var willNotifyEmpty = false
    private var isRunning = false
    
    private var idleAnimations: [FaceAnimation] = []
    private var interruptAnimations: [FaceAnimation]?
    
    convenience public init(frame: CGRect, faceImageName: String) {
        self.init(frame: frame)
        self.faceImageName = faceImageName
        drawFace()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupAnimations()
//        subscribeToAnimationGroupNotify()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func async(faceAnimations: [FaceAnimation]) {
        // Loop through and perform each faceAnimation
        for faceAnimation in faceAnimations {
            async(faceAnimation: faceAnimation)
        }
    }
    
    public func async(faceAnimation: FaceAnimation) {
        // Animate eyes, nose, mouth, and background
        if let eyebrowsAnimation = faceAnimation.eyebrowsAnimation {
            self.animate(facialFeatureAnimation: eyebrowsAnimation, layer: self.eyebrowsLayer, duration: faceAnimation.duration)
        }
        if let eyebrowsPosition = faceAnimation.eyebrowsPosition {
            self.animate(facialFeatureAnimation: eyebrowsPosition.getLeftEyebrowAnimation(), layer: self.leftEyebrowShapeLayer, duration: faceAnimation.duration)
            self.animate(facialFeatureAnimation: eyebrowsPosition.getRightEyebrowAnimation(), layer: self.rightEyebrowShapeLayer, duration: faceAnimation.duration)
        }
        if let eyesAnimation = faceAnimation.eyesAnimation {
            self.animate(facialFeatureAnimation: eyesAnimation, layer: self.eyesLayer, duration: faceAnimation.duration)
        }
        if let noseAnimation = faceAnimation.noseAnimation {
            self.animate(facialFeatureAnimation: noseAnimation, layer: self.noseShapeLayer, duration: faceAnimation.duration)
        }
        if let mouthAnimation = faceAnimation.mouthAnimation {
            self.animate(facialFeatureAnimation: mouthAnimation, layer: self.mouthShapeLayer, duration: faceAnimation.duration)
        }
        if let mouthPosition = faceAnimation.mouthPosition {
            self.animate(facialFeatureAnimation: mouthPosition, layer: self.mouthShapeLayer, duration: faceAnimation.duration)
        }
        if let backgroundAnimation = faceAnimation.backgroundAnimation {
            self.animate(facialFeatureAnimation: backgroundAnimation, layer: self.backgroundFaceLayer, duration: faceAnimation.duration)
        }
    }
    
    public func interrupt(with faceAnimation: FaceAnimation) {
        interrupt(with: [faceAnimation])
    }
    
    public func interrupt(with faceAnimations: [FaceAnimation]) {
        // Add interruptAnimations to faceAnimations
        interruptAnimations = faceAnimations
        
        // If isRunning, set shouldEmptyQueue to true to empty it and queue up the interrupt animations TODO: Is this okay to do or is this making the logic too complex? Is there a simpler way?
        if isRunning {
            shouldEmptyQueue = true
        }
        
        // Call start which will start running interrupt and idle animations if it needs to
        start()
    }
    
    public func queue(faceAnimations: [FaceAnimation]) {
        // Loops through animations, and once they are all done, loops through the list again
        for faceAnimation in faceAnimations {
            queue(faceAnimation: faceAnimation)
        }
    }
    
    public func queue(faceAnimation: FaceAnimation) {
        // Add faceAnimation to animationsQueue
        animationsQueue.async(group: animationGroup) {
            self.async(faceAnimation: faceAnimation)
            
            Thread.sleep(forTimeInterval: faceAnimation.duration)
        }
        
        // Subscribe to animation group notify
        subscribeToAnimationGroupNotify()
    }
    
    public func setIdleAnimations(_ faceAnimations: [FaceAnimation]) {
        // Set idle animations
        idleAnimations = faceAnimations
        
        // Call start which will start running interrupt and idle animations if it needs to
        start()
    }
    
    public func blink(duration: CFTimeInterval = 0.2, blinkMinXScale: CGFloat = 0.8, blinkMinYScale: CGFloat = 0.2) {
//        animationsQueue.async(group: animationGroup) {
            let xAnimation = CAKeyframeAnimation(keyPath: "transform.scale.x")
            let yAnimation = CAKeyframeAnimation(keyPath: "transform.scale.y")
            xAnimation.duration = duration
            yAnimation.duration = duration

            xAnimation.values = [1, blinkMinXScale, 1]
            xAnimation.keyTimes = [0, 0.5, 1]
            yAnimation.values = [1, blinkMinYScale, 1]
            yAnimation.keyTimes = [0, 0.5, 1]
            
            DispatchQueue.main.async {
                self.leftEyeShapeLayer.add(xAnimation, forKey: nil)
                self.rightEyeShapeLayer.add(xAnimation, forKey: nil)
                self.leftEyeShapeLayer.add(yAnimation, forKey: nil)
                self.rightEyeShapeLayer.add(yAnimation, forKey: nil)
            }
//        }
    }
    
    private func drawFace() {
        let leftEyebrowShapeLayerPath = UIBezierPath()
        leftEyebrowShapeLayerPath.move(to: CGPoint(x: self.frame.width * 22 / 75, y: self.frame.height * 13 / 30))
        leftEyebrowShapeLayerPath.addQuadCurve(to: CGPoint(x: self.frame.width * 59 / 150, y: self.frame.height * 13 / 30), controlPoint: CGPoint(x: self.frame.width * 103 / 300, y: self.frame.height * 32 / 75))
        
        leftEyebrowShapeLayer = CAShapeLayer()
        leftEyebrowShapeLayer.path = leftEyebrowShapeLayerPath.cgPath
        leftEyebrowShapeLayer.lineWidth = self.frame.width * 2 / 75
        leftEyebrowShapeLayer.strokeColor = UIColor.black.cgColor
        leftEyebrowShapeLayer.fillColor = UIColor.clear.cgColor
        leftEyebrowShapeLayer.lineCap = .round
        
        let rightEyebrowShapeLayerPath = UIBezierPath()
        rightEyebrowShapeLayerPath.move(to: CGPoint(x: self.frame.width * 91 / 150, y: self.frame.height * 13 / 30))
        rightEyebrowShapeLayerPath.addQuadCurve(to: CGPoint(x: self.frame.width * 53 / 75, y: self.frame.height * 13 / 30), controlPoint: CGPoint(x: self.frame.width * 197 / 300, y: eslf.frame.height * 32 / 75))
        
        rightEyebrowShapeLayer = CAShapeLayer()
        rightEyebrowShapeLayer.path = rightEyebrowShapeLayerPath.cgPath
        rightEyebrowShapeLayer.lineWidth = self.frame.width * 2 / 75
        rightEyebrowShapeLayer.strokeColor = UIColor.black.cgColor
        rightEyebrowShapeLayer.fillColor = UIColor.clear.cgColor
        rightEyebrowShapeLayer.lineCap = .round
        
        eyebrowsLayer = CALayer()
        eyebrowsLayer.addSublayer(leftEyebrowShapeLayer)
        eyebrowsLayer.addSublayer(rightEyebrowShapeLayer)
        
        leftEyeShapeLayer = CAShapeLayer()
        leftEyeShapeLayer.frame = CGRect(x: self.frame.width * 31 / 100, y: self.frame.height * 7 / 15, width: self.frame.width * 1 / 15, height: self.frame.height * 1 / 15)
        leftEyeShapeLayer.path = UIBezierPath(ovalIn: leftEyeShapeLayer.frame).cgPath
        leftEyeShapeLayer.bounds = leftEyeShapeLayer.path!.boundingBox
        leftEyeShapeLayer.strokeColor = UIColor.black.cgColor
        leftEyeShapeLayer.fillColor = UIColor.black.cgColor
        
        rightEyeShapeLayer = CAShapeLayer()
        rightEyeShapeLayer.frame = CGRect(x: self.frame.width * 187 / 300, y: self.frame.height * 7 / 15, width: self.frame.width * 1 / 15, height: self.frame.height * 1 / 15)
        rightEyeShapeLayer.path = UIBezierPath(ovalIn: rightEyeShapeLayer.frame).cgPath
        rightEyeShapeLayer.bounds = rightEyeShapeLayer.path!.boundingBox
        rightEyeShapeLayer.strokeColor = UIColor.black.cgColor
        rightEyeShapeLayer.fillColor = UIColor.black.cgColor
        
        eyesLayer = CALayer()
        eyesLayer.addSublayer(leftEyeShapeLayer)
        eyesLayer.addSublayer(rightEyeShapeLayer)
        
        originalNosePath = UIBezierPath()
        originalNosePath.move(to: CGPoint(x: self.frame.width * 1 / 2, y: self.frame.height * 77 / 150))
        originalNosePath.addLine(to: CGPoint(x: self.frame.width * 14 / 25, y: self.frame.height * 49 / 75))
        originalNosePath.addLine(to: CGPoint(x: self.frame.width * 13 / 30, y: self.frame.height * 49 / 75))
        
        noseShapeLayer = CAShapeLayer()
        noseShapeLayer.path = originalNosePath.cgPath
        noseShapeLayer.strokeColor = UIColor.black.cgColor
        noseShapeLayer.fillColor = UIColor.clear.cgColor
        noseShapeLayer.lineWidth = self.frame.width * 2 / 75
        noseShapeLayer.lineCap = .round
        noseShapeLayer.lineJoin = .round
        
        originalMouthPath = UIBezierPath()
        originalMouthPath.move(to: CGPoint(x: self.frame.width * 61 / 150, y: self.frame.height * 19 / 25))
        originalMouthPath.addQuadCurve(to: CGPoint(x: self.frame.width * 89 / 150, y: self.frame.height * 19 / 25), controlPoint: CGPoint(x: self.frame.width * 1 / 2, y: self.frame.height * 58 / 75))
        
        mouthShapeLayer = CAShapeLayer()
        mouthShapeLayer.path = originalMouthPath.cgPath
        mouthShapeLayer.strokeColor = UIColor.black.cgColor
        mouthShapeLayer.fillColor = UIColor.clear.cgColor
        mouthShapeLayer.lineWidth = self.frame.width * 2 / 75
        mouthShapeLayer.lineCap = .round
        
        backgroundFaceImage = UIImage(named: faceImageName!)
        backgroundFaceLayer = CALayer()
        backgroundFaceLayer.frame = CGRect(x: self.frame.width * 1 / 2, y: self.frame.height * 1 / 2, width: self.frame.width, height: self.frame.height)
        backgroundFaceLayer.position = CGPoint(x: 0.0, y: 0.0)
        backgroundFaceLayer.anchorPoint = CGPoint(x: 0.0, y: 0.0)
//        backgroundFaceLayer.path = originalBackgroundFacePath.cgPath
        backgroundFaceLayer.contents = backgroundFaceImage.cgImage
        
        fullFaceLayer = CALayer()
        
        fullFaceLayer.addSublayer(backgroundFaceLayer)
        fullFaceLayer.addSublayer(mouthShapeLayer)
        fullFaceLayer.addSublayer(noseShapeLayer)
        fullFaceLayer.addSublayer(eyesLayer)
        fullFaceLayer.addSublayer(eyebrowsLayer)
        
        self.layer.addSublayer(fullFaceLayer)
    }
    
    private func start() {
        // Ensure is not running otherwise return
        guard !isRunning else {
            return
        }
        
        // Queue the idle animations
        queueInterruptAndIdleAnimations()
    }
    
    private func queueInterruptAndIdleAnimations() {
        // Add interruptAnimations to queue and set to nil
        if let interruptAnimations = self.interruptAnimations {
            self.queue(faceAnimations: interruptAnimations)
            self.interruptAnimations = nil
        }
        
        self.queue(faceAnimations: self.idleAnimations)
    }
    
    private func subscribeToAnimationGroupNotify() {
        // Ensure willNotifyEmpty is false to to only run this once
        guard !willNotifyEmpty else {
            return
        }
        
        // Set willNotifyEmpty to true
        willNotifyEmpty = true
        
        isRunning = true
        animationGroup.notify(queue: animationsQueue) {
            // Set isRunning to false since the queue is empty
            self.isRunning = false
            print("hi")
            
            // Set shouldEmptyQueue to false, as this block indicates the queue has been emptied
            self.shouldEmptyQueue = false
            
            // Set willNotifyEmpty to false to allow for subscription to notifications again
            self.willNotifyEmpty = false
            
            // Queue interrupt and idle animations
            self.queueInterruptAndIdleAnimations()
        }
    }
    
    private func animate(facialFeatureAnimation: FacialFeatureAnimation, layer: CALayer, duration: CFTimeInterval) {
        guard !shouldEmptyQueue else {
            return
        }
        
        if let moveCurveAnimation = facialFeatureAnimation as? MoveCurveAnimation {
            let animation = CAKeyframeAnimation(keyPath: "position")
            animation.duration = duration
            
            let path = UIBezierPath()
            path.move(to: layer.position)
            path.addQuadCurve(to: moveCurveAnimation.moveToQuadCurvePoint, controlPoint: moveCurveAnimation.moveToQuadCurveControlPoint)
            
//            animation.values = [layer.position, moveAnimation.moveToPosition]
            animation.path = path.cgPath
            animation.keyTimes = [0, 1]
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            DispatchQueue.main.async {
                layer.position = moveCurveAnimation.moveToQuadCurvePoint
                layer.add(animation, forKey: nil)
            }
        }
        
        if let moveAnimation = facialFeatureAnimation as? MoveAnimation {
            let animation = CAKeyframeAnimation(keyPath: "position")
            animation.duration = duration
            
            animation.values = [layer.position, moveAnimation.moveToPosition]
            animation.keyTimes = [0, 1]
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            DispatchQueue.main.async {
                layer.position = moveAnimation.moveToPosition
                layer.add(animation, forKey: nil)
            }
        }
        
        if let lineAnimation = facialFeatureAnimation as? LineAnimation, let shapeLayer = layer as? CAShapeLayer {
            let animation = CAKeyframeAnimation(keyPath: "path")
            animation.duration = duration
            
            let path = UIBezierPath()
            path.move(to: lineAnimation.linePosition)
            path.addQuadCurve(to: lineAnimation.quadCurvePoint, controlPoint: lineAnimation.quadCurveControlPoint)
            
            animation.values = [shapeLayer.path!, path.cgPath]
            animation.keyTimes = [0, 1]
            
            DispatchQueue.main.async {
                shapeLayer.path = path.cgPath
                shapeLayer.add(animation, forKey: nil)
            }
        }
        
        if let blinkAnimation = facialFeatureAnimation as? BlinkAnimation {
            let blinkMinXScale: CGFloat = blinkAnimation.blinkMinXScale ?? DEFAULT_BLINK_MIN_X_SCALE
            let blinkMinYScale: CGFloat = blinkAnimation.blinkMinYScale ?? DEFAULT_BLINK_MIN_Y_SCALE
            
            blink(
                duration: duration,
                blinkMinXScale: blinkMinXScale,
                blinkMinYScale: blinkMinYScale
            )
        }
        
        if let opacityAnimation = facialFeatureAnimation as? OpacityAnimation {
            let animation = CAKeyframeAnimation(keyPath: "opacity")
            animation.duration = duration
            
            animation.values = [layer.opacity, opacityAnimation.targetOpacity]
            animation.keyTimes = [0, 1]
            
            DispatchQueue.main.async {
                layer.opacity = opacityAnimation.targetOpacity
                layer.add(animation, forKey: nil)
            }
        }
    }
    
}
