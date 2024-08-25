////
////  FaceAnimationRepresentable.swift
////
////
////  Created by Alex Coundouriotis on 10/26/23.
////
//
//import SwiftUI
//import UIKit
//
//public struct FaceAnimationViewRepresentable: UIViewRepresentable {
//    
//    // TODO: Queueing animations will have to be done through variable updates, when one updates, it'll have to queue and then set to nil immediately or something like that
//    
//    public var frame: CGRect
//    public var eyesImageName: String
//    public var mouthImageName: String
//    public var noseImageName: String
//    public var faceImageName: String
//    public var facialFeaturesScaleFactor: CGFloat
//    public var eyesPositionFactor: CGFloat
//    public var color: UIColor
//    public var startAnimation: FaceAnimation?
//    private var initialQueuedAnimations: [FaceAnimation]
//    private var initialIdleAnimations: [FaceAnimation]
//    
//    
//    @State private var faceAnimationView: FaceAnimationView
//    
//    @State private var isRandomBlinkRunning: Bool = false
//    
//    private let randomBlinkSecondsMin: UInt64 = 2
//    private let randomBlinkSecondsMax: UInt64 = 12
//    
//    public init(frame: CGRect, eyesImageName: String, mouthImageName: String, noseImageName: String, faceImageName: String, facialFeaturesScaleFactor: CGFloat, eyesPositionFactor: CGFloat, faceRenderingMode: UIImage.RenderingMode, color: UIColor, startAnimation: FaceAnimation? = nil, queuedAnimations: [FaceAnimation] = [], idleAnimations: [FaceAnimation] = []) {
//        self.frame = frame
//        self.eyesImageName = eyesImageName
//        self.mouthImageName = mouthImageName
//        self.noseImageName = noseImageName
//        self.faceImageName = faceImageName
//        self.facialFeaturesScaleFactor = facialFeaturesScaleFactor
//        self.eyesPositionFactor = eyesPositionFactor
//        self.color = color
//        self.startAnimation = startAnimation
//        self.initialQueuedAnimations = queuedAnimations
//        self.initialIdleAnimations = idleAnimations
//        
//        self._faceAnimationView = State(initialValue: FaceAnimationView(
//            frame: frame,
//            eyesImageName: eyesImageName,
//            mouthImageName: mouthImageName,
//            noseImageName: noseImageName,
//            faceImageName: faceImageName,
//            facialFeaturesScaleFactor: facialFeaturesScaleFactor,
//            eyesPositionFactor: eyesPositionFactor,
//            faceRenderingMode: faceRenderingMode,
//            startAnimation: startAnimation))
//////        self.queuedAnimations = []
//    }
//    
//    public func makeUIView(context: Context) -> FaceAnimationView {
////        faceAnimationView = FaceAnimationView(
////            frame: frame,
////            faceImageName: faceImageName,
////            startAnimation: startAnimation)
//        
////        faceAnimationView!.tintColor = color
//        
////        startRandomBlink()
//        
//        faceAnimationView.tintColor = color
//        
//        startRandomBlink()
//        
//        // Set idle animations and set array to empty
//        if !initialIdleAnimations.isEmpty {
//            faceAnimationView.setIdleAnimations(initialIdleAnimations)
//        }
////        self.idleAnimations = []
//        
//        // Queue animations and set array to empty
//        if !initialQueuedAnimations.isEmpty {
//            faceAnimationView.queue(faceAnimations: initialQueuedAnimations)
//        }
//        
//        return faceAnimationView
//    }
//    
//    public func updateUIView(_ uiView: FaceAnimationView, context: Context) {
//        uiView.frame = frame
//        uiView.tintColor = color
//        
////        uiView.showsMouth = showsMouth
//        
//        uiView.eyesImageName = eyesImageName
//        uiView.mouthImageName = mouthImageName
//        uiView.noseImageName = noseImageName
//        uiView.faceImageName = faceImageName
//        
////        // Set idle animations
////        if !idleAnimations.isEmpty {
////            uiView.queue(faceAnimations: idleAnimations)
////
////            DispatchQueue.main.async {
////                self.idleAnimations = []
////            }
////        }
////
////        // Set queued animations
////        if !queuedAnimations.isEmpty {
////            uiView.queue(faceAnimations: queuedAnimations)
////
////            DispatchQueue.main.async {
////                self.queuedAnimations = []
////            }
////        }
//        
//        uiView.setNeedsDisplay()
//        uiView.setNeedsLayout()
//        uiView.layoutIfNeeded()
//    }
//    
//    func setIdleAnimations(_ faceAnimationSequence: FaceAnimationSequence) {
//        faceAnimationView.setIdleAnimations(faceAnimationSequence.animations)
//    }
//    
//    func queue(_ faceAnimationSequence: FaceAnimationSequence) {
//        self.queue(faceAnimationSequence.animations)
//    }
//    
//    func queue(_ faceAnimations: [FaceAnimation]) {
//        faceAnimationView.queue(faceAnimations: faceAnimations)
//    }
//    
//    public func startRandomBlink() {
//        // Blink after random seconds, between 4 and 12
//        Task {
//            // TODO: Is it okay to do a while true here?
//            while true {
//                await blinkAfterRandomSeconds()
//            }
//        }
//    }
//    
//    public func blinkAfterRandomSeconds() async {
//        do {
//            try await Task.sleep(nanoseconds: UInt64.random(in: randomBlinkSecondsMin...randomBlinkSecondsMax) * 1_000_000_000)
//        } catch {
//            print("Error sleeping Task when blinking after random seconds in GlobalTabBarFaceController... \(error)")
//        }
//        
//        blink()
//    }
//    
//    public func blink() {
//        faceAnimationView.async(faceAnimation: BlinkFaceAnimation())
//    }
//    
//    public func setColor(_ color: UIColor) {
//        faceAnimationView.tintColor = color
//        
//        faceAnimationView.setNeedsDisplay()
//    }
//    
//}
//
//#Preview {
//    ZStack {
//        VStack {
//            Spacer()
//            HStack {
//                Spacer()
//                FaceAnimationViewRepresentable(
//                    frame: CGRect(x: 0, y: 0, width: 200, height: 200),
//                    eyesImageName: "Man Eyes",
//                    mouthImageName: "Man Mouth",
//                    noseImageName: "WriteSmith Original Nose",
//                    faceImageName: "WriteSmith Original Background",
//                    facialFeaturesScaleFactor: 0.76,
//                    eyesPositionFactor: 2.0/5.0,
//                    faceRenderingMode: .alwaysTemplate,
//                    color: .green,
//                    startAnimation: SmileCenterFaceAnimation(duration: 0.0),
//                    queuedAnimations: [SmileLookLeftFaceAnimation(), WaitFaceAnimation(duration: 8.0)],
//                    idleAnimations: [SmileLookLeftFaceAnimation(), SmileLookRightFaceAnimation()]
//                )
//                .frame(width: 200, height: 200)
////                .background(.green)
//                Spacer()
//            }
//            Spacer()
//        }
//    }
//}
//
//
