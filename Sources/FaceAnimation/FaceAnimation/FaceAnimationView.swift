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
    
    convenience public init(frame: CGRect, faceImageName: String, startAnimation: FaceAnimation? = nil) {
        self.init(frame: frame)
        self.faceImageName = faceImageName
        setupFaceLayers()
        setupFacePaths()
        
        if let startAnimation = startAnimation {
            self.queue(faceAnimation: startAnimation)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupAnimations()
//        subscribeToAnimationGroupNotify()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        leftEyebrowShapeLayer.lineWidth = self.frame.width * 2 / 75
        leftEyebrowShapeLayer.strokeColor = tintColor.cgColor
        leftEyebrowShapeLayer.fillColor = UIColor.clear.cgColor
        leftEyebrowShapeLayer.lineCap = .round
        
        rightEyebrowShapeLayer.lineWidth = self.frame.width * 2 / 75
        rightEyebrowShapeLayer.strokeColor = tintColor.cgColor
        rightEyebrowShapeLayer.fillColor = UIColor.clear.cgColor
        rightEyebrowShapeLayer.lineCap = .round
        
        leftEyeShapeLayer.bounds = leftEyeShapeLayer.path!.boundingBox
        leftEyeShapeLayer.strokeColor = tintColor.cgColor
        leftEyeShapeLayer.fillColor = tintColor.cgColor
        
        rightEyeShapeLayer.bounds = rightEyeShapeLayer.path!.boundingBox
        rightEyeShapeLayer.strokeColor = tintColor.cgColor
        rightEyeShapeLayer.fillColor = tintColor.cgColor
        
        noseShapeLayer.strokeColor = tintColor.cgColor
        noseShapeLayer.fillColor = UIColor.clear.cgColor
        noseShapeLayer.lineWidth = self.frame.width * 2 / 75
        noseShapeLayer.lineCap = .round
        noseShapeLayer.lineJoin = .round
        
        mouthShapeLayer.strokeColor = tintColor.cgColor
        mouthShapeLayer.fillColor = UIColor.clear.cgColor
        mouthShapeLayer.lineWidth = self.frame.width * 2 / 75
        mouthShapeLayer.lineCap = .round
        
        backgroundFaceImage = UIImage(named: faceImageName!)
        let backgroundFaceImageSize = CGSize(width: self.bounds.width, height: self.bounds.height)
        let backgroundFaceImageRenderer = UIGraphicsImageRenderer(size: backgroundFaceImageSize)
        let tintedBackgroundFaceImage = backgroundFaceImageRenderer.image {graphicsImageRendererContext in
            backgroundFaceImage!.withTintColor(self.tintColor).draw(in: CGRect(origin: CGPoint.zero, size: backgroundFaceImageSize))
        }
        
//        backgroundFaceLayer.path = originalBackgroundFacePath.cgPath
        backgroundFaceLayer.contents = tintedBackgroundFaceImage.cgImage
        
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
            // Ensure shouldEmptyQueue is false, otherwise return to prevent delays when emptying queue
            guard !self.shouldEmptyQueue else {
                return
            }
            
            // Call async in the queue to queue the animation
            self.async(faceAnimation: faceAnimation)
            
            // Sleep for the duration of the animation to allow the animation to complete before proceeding
            Thread.sleep(forTimeInterval: faceAnimation.duration)
        }
        
        // Subscribe to animation group notify
        subscribeToAnimationGroupNotify()
    }
    
    public func setIdleAnimations(_ faceAnimations: [FaceAnimation], shouldInterrupt: Bool = true) {
        // Set idle animations
        idleAnimations = faceAnimations
        
        // If shouldInterrupt and isRunning, set shouldEmptyQueue to interrupt
        if shouldInterrupt && isRunning {
            shouldEmptyQueue = true
        }
        
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
    
    private func setupFaceLayers() {
        leftEyebrowShapeLayer = CAShapeLayer()
        rightEyebrowShapeLayer = CAShapeLayer()
        
        eyebrowsLayer = CALayer()
        eyebrowsLayer.addSublayer(leftEyebrowShapeLayer)
        eyebrowsLayer.addSublayer(rightEyebrowShapeLayer)
        
        leftEyeShapeLayer = CAShapeLayer()
        rightEyeShapeLayer = CAShapeLayer()
        
        eyesLayer = CALayer()
        eyesLayer.addSublayer(leftEyeShapeLayer)
        eyesLayer.addSublayer(rightEyeShapeLayer)
        
        originalNosePath = UIBezierPath()
        noseShapeLayer = CAShapeLayer()
        
        originalMouthPath = UIBezierPath()
        mouthShapeLayer = CAShapeLayer()
        
        backgroundFaceLayer = CALayer()
        
        fullFaceLayer = CALayer()
        
        fullFaceLayer.addSublayer(backgroundFaceLayer)
        fullFaceLayer.addSublayer(mouthShapeLayer)
        fullFaceLayer.addSublayer(noseShapeLayer)
        fullFaceLayer.addSublayer(eyesLayer)
        fullFaceLayer.addSublayer(eyebrowsLayer)
        
        self.layer.addSublayer(fullFaceLayer)
    }
    
    private func setupFacePaths() {
        let leftEyebrowShapeLayerPath = UIBezierPath()
        leftEyebrowShapeLayerPath.move(to: CGPoint(x: self.frame.width * 22 / 75, y: self.frame.height * 13 / 30))
        leftEyebrowShapeLayerPath.addQuadCurve(to: CGPoint(x: self.frame.width * 59 / 150, y: self.frame.height * 13 / 30), controlPoint: CGPoint(x: self.frame.width * 103 / 300, y: self.frame.height * 32 / 75))
        
        leftEyebrowShapeLayer.path = leftEyebrowShapeLayerPath.cgPath
        
        let rightEyebrowShapeLayerPath = UIBezierPath()
        rightEyebrowShapeLayerPath.move(to: CGPoint(x: self.frame.width * 91 / 150, y: self.frame.height * 13 / 30))
        rightEyebrowShapeLayerPath.addQuadCurve(to: CGPoint(x: self.frame.width * 53 / 75, y: self.frame.height * 13 / 30), controlPoint: CGPoint(x: self.frame.width * 197 / 300, y: self.frame.height * 32 / 75))
        
        rightEyebrowShapeLayer.path = rightEyebrowShapeLayerPath.cgPath
        
        leftEyeShapeLayer.frame = CGRect(x: self.frame.width * 31 / 100, y: self.frame.height * 7 / 15, width: self.frame.width * 1 / 15, height: self.frame.height * 1 / 15)
        leftEyeShapeLayer.path = UIBezierPath(ovalIn: leftEyeShapeLayer.frame).cgPath
        
        rightEyeShapeLayer.frame = CGRect(x: self.frame.width * 187 / 300, y: self.frame.height * 7 / 15, width: self.frame.width * 1 / 15, height: self.frame.height * 1 / 15)
        rightEyeShapeLayer.path = UIBezierPath(ovalIn: rightEyeShapeLayer.frame).cgPath
        
        originalNosePath.move(to: CGPoint(x: self.frame.width * 1 / 2, y: self.frame.height * 77 / 150))
        originalNosePath.addLine(to: CGPoint(x: self.frame.width * 14 / 25, y: self.frame.height * 49 / 75))
        originalNosePath.addLine(to: CGPoint(x: self.frame.width * 13 / 30, y: self.frame.height * 49 / 75))
        
        noseShapeLayer.path = originalNosePath.cgPath
        
        originalMouthPath.move(to: CGPoint(x: self.frame.width * 61 / 150, y: self.frame.height * 19 / 25))
        originalMouthPath.addQuadCurve(to: CGPoint(x: self.frame.width * 89 / 150, y: self.frame.height * 19 / 25), controlPoint: CGPoint(x: self.frame.width * 1 / 2, y: self.frame.height * 58 / 75))
        
        mouthShapeLayer.path = originalMouthPath.cgPath
        
        backgroundFaceLayer.frame = CGRect(x: self.frame.width * 1 / 2, y: self.frame.height * 1 / 2, width: self.frame.width, height: self.frame.height)
        backgroundFaceLayer.position = CGPoint(x: 0.0, y: 0.0)
        backgroundFaceLayer.anchorPoint = CGPoint(x: 0.0, y: 0.0)
//        backgroundFaceLayer.path = originalBackgroundFacePath.cgPath
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
            
            DispatchQueue.main.async {
                let path = UIBezierPath()
                path.move(to: lineAnimation.getLinePosition(width: self.frame.width, height: self.frame.height))
                path.addQuadCurve(to: lineAnimation.getQuadCurvePoint(width: self.frame.width, height: self.frame.height), controlPoint: lineAnimation.getQuadCurveControlPoint(width: self.frame.width, height: self.frame.height))
                
                animation.values = [shapeLayer.path!, path.cgPath]
                animation.keyTimes = [0, 1]
            
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
