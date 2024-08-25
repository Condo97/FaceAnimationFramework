//
// FaceAnimationView.swift
// FaceAnimationTest
//
// Created by Alex Coundouriotis on 9/9/23.
//

import Foundation
import UIKit

open class FaceAnimationView: UIView {
    
    public var showsMouth: Bool!
    
    public var eyesImageName: String?
    public var mouthImageName: String?
    public var noseImageName: String?
    public var faceImageName: String?
    
    public var facialFeaturesScaleFactor: CGFloat!
    
    public var eyesPositionFactor: CGFloat!
    
    public var faceRenderingMode: UIImage.RenderingMode!
    
    private let DEFAULT_BLINK_MIN_X_SCALE = 0.8
    private let DEFAULT_BLINK_MIN_Y_SCALE = 0.2
    
    private var fullFaceLayer: CALayer!
    
    private var facialFeaturesLayer: CALayer!
    
    private var eyesLayer: CALayer!
    private var eyesImage: UIImage!
    
    private var noseLayer: CALayer!
    private var noseImage: UIImage!
    
    private var mouthLayer: CALayer!
    private var mouthImage: UIImage!
    
    private var backgroundFaceLayer: CALayer!
    private var backgroundFaceImage: UIImage!
    
    private var animationsQueue: DispatchQueue = DispatchQueue(label: "animationsQueue")
    private var animationGroup: DispatchGroup = DispatchGroup()
    
    private var shouldEmptyQueue = false
    private var willNotifyEmpty = false
    private var isRunning = false
    
    private var idleAnimations: [FaceAnimation] = []
    private var interruptAnimations: [FaceAnimation]?
    
    private lazy var facialFeaturesView: UIView = {
        let view = UIView(frame: CGRect.zero)
        self.addSubview(view)
        return view
    }()
    
    convenience public init(frame: CGRect, eyesImageName: String, mouthImageName: String, noseImageName: String, faceImageName: String, facialFeaturesScaleFactor: CGFloat /*= 1.0*/, eyesPositionFactor: CGFloat /*= 2.0/5.0*/, faceRenderingMode: UIImage.RenderingMode, startAnimation: FaceAnimation? = nil) {
        self.init(frame: frame)
        self.showsMouth = showsMouth
        self.eyesImageName = eyesImageName
        self.mouthImageName = mouthImageName
        self.noseImageName = noseImageName
        self.faceImageName = faceImageName
        self.facialFeaturesScaleFactor = facialFeaturesScaleFactor
        self.eyesPositionFactor = eyesPositionFactor
        self.faceRenderingMode = faceRenderingMode
        setupFaceLayers()
        setupFacePaths()
        
        if let startAnimation = startAnimation {
            self.queue(faceAnimation: startAnimation)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        // Efficiently update layer frames instead of recreating them
        updateLayerFrames()
    }
    
    private func updateLayerFrames() {
        let newSize = CGSize(width: self.bounds.width * facialFeaturesScaleFactor,
                             height: self.bounds.height * facialFeaturesScaleFactor)

        eyesLayer.frame = CGRect(origin: .zero, size: newSize)
        noseLayer.frame = CGRect(origin: .zero, size: newSize)
        mouthLayer.frame = CGRect(origin: .zero, size: newSize)
        backgroundFaceLayer.frame = CGRect(origin: .zero, size: self.bounds.size)
    }

    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Efficiently update images instead of drawing every time
        updateImages()
    }
    
    private func updateImages() {
        eyesLayer.contents = createTintedImage(named: eyesImageName)
        noseLayer.contents = createTintedImage(named: noseImageName)
        mouthLayer.contents = createTintedImage(named: mouthImageName)
        backgroundFaceLayer.contents = createTintedImage(named: faceImageName)
    }
    
    private func createTintedImage(named imageName: String?) -> CGImage? {
        guard let imageName = imageName,
              let image = UIImage(named: imageName) else {
            return nil
        }
        
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        return renderer.image { context in
            if faceRenderingMode == .alwaysOriginal || faceRenderingMode == .automatic {
                image.draw(in: context.format.bounds)
            } else {
                image.withTintColor(self.tintColor).draw(in: context.format.bounds)
            }
        }.cgImage
    }
    
    public func async(faceAnimations: [FaceAnimation]) {
        // Loop through and perform each faceAnimation
        for faceAnimation in faceAnimations {
            async(faceAnimation: faceAnimation)
        }
    }
    
    public func async(faceAnimation: FaceAnimation) {
        // Animate eyes, nose, mouth, and background
        if let eyesAnimation = faceAnimation.eyesAnimation {
            self.animate(facialFeatureAnimation: eyesAnimation, layer: self.eyesLayer, duration: faceAnimation.duration)
        }
        if let noseAnimation = faceAnimation.noseAnimation {
            self.animate(facialFeatureAnimation: noseAnimation, layer: self.noseLayer, duration: faceAnimation.duration)
        }
        if let mouthAnimation = faceAnimation.mouthAnimation {
            self.animate(facialFeatureAnimation: mouthAnimation, layer: self.mouthLayer, duration: faceAnimation.duration)
        }
        if let mouthPosition = faceAnimation.mouthPosition {
            self.animate(facialFeatureAnimation: mouthPosition, layer: self.mouthLayer, duration: faceAnimation.duration)
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
    
    public func blink(duration: CFTimeInterval = 0.2, blinkMinXScale: CGFloat = 1.0, blinkMinYScale: CGFloat = 0.2) {
        let xAnimation = CAKeyframeAnimation(keyPath: "transform.scale.x")
        let yAnimation = CAKeyframeAnimation(keyPath: "transform.scale.y")
        xAnimation.duration = duration
        yAnimation.duration = duration
        
        let xMoveAnimation = CAKeyframeAnimation(keyPath: "position.x")
        let yMoveAnimation = CAKeyframeAnimation(keyPath: "position.y")
        xMoveAnimation.duration = duration
        yMoveAnimation.duration = duration

        DispatchQueue.main.async {
            xMoveAnimation.values = [0, 0, 0]
            xMoveAnimation.keyTimes = [0, 0.5, 1]
            yMoveAnimation.values = [0, self.frame.size.height * self.eyesPositionFactor, 0]
            yMoveAnimation.keyTimes = [0, 0.5, 1]
            
            self.eyesLayer.add(xAnimation, forKey: nil)
            self.eyesLayer.add(yAnimation, forKey: nil)
            self.eyesLayer.add(xMoveAnimation, forKey: nil)
            self.eyesLayer.add(yMoveAnimation, forKey: nil)
        }
    }
    
    private func setupFaceLayers() {
        
        eyesLayer = CALayer()
        noseLayer = CALayer()
        mouthLayer = CALayer()
        
        backgroundFaceLayer = CALayer()
        
        facialFeaturesLayer = CALayer()
        
        fullFaceLayer = CALayer()
        
        backgroundFaceLayer.addSublayer(noseLayer)
        backgroundFaceLayer.addSublayer(eyesLayer)
        backgroundFaceLayer.addSublayer(mouthLayer)
        
        self.layer.addSublayer(backgroundFaceLayer)
        self.facialFeaturesView.layer.addSublayer(facialFeaturesLayer)
    }
    
    private func setupFacePaths() {
        updateLayerFrames()  // Calls a new method to update frames
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
        
        // Set isRunning to true to indicate that animations are running
        isRunning = true
        animationGroup.notify(queue: animationsQueue) {
            // Set isRunning to false since the queue is empty
            self.isRunning = false
            
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
                path.move(to: lineAnimation.getLinePosition(width: self.facialFeaturesView.frame.width, height: self.facialFeaturesView.frame.height))
                path.addQuadCurve(to: lineAnimation.getQuadCurvePoint(width: self.facialFeaturesView.frame.width, height: self.facialFeaturesView.frame.height), controlPoint: lineAnimation.getQuadCurveControlPoint(width: self.facialFeaturesView.frame.width, height: self.facialFeaturesView.frame.height))
                
                animation.values = [shapeLayer.path!, path.cgPath]
                animation.keyTimes = [0, 1]
                
                shapeLayer.path = path.cgPath
                shapeLayer.add(animation, forKey: nil)
            }
        }
        
        if let blinkAnimation = facialFeatureAnimation as? BlinkAnimation {
            let blinkMinXScale: CGFloat = blinkAnimation.blinkMinXScale ?? DEFAULT_BLINK_MIN_X_SCALE
            let blinkMinYScale: CGFloat = blinkAnimation.blinkMinYScale ?? DEFAULT_BLINK_MIN_Y_SCALE
            
            blink(duration: duration, blinkMinXScale: blinkMinXScale, blinkMinYScale: blinkMinYScale)
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
