//
//  MainGameBoardElementsControllingHelpers.swift
//  ARHandSimulatorFever
//
//  Created by Kagamigawa on 2020/05/06.
//  Copyright © 2020 JohnBo. All rights reserved.
//

import Foundation
import SceneKit

extension MainViewController {
    @objc
    func throwBall(_ timer:Timer) -> Void {
        guard self.sessionState == .readyToThrowOut else { print("Can't throw out the ball, now is \(sessionState)."); return }
        guard self.motionManager.accelerometerData != nil else {print("motionManager is down."); return }
        guard let currentFrame = sceneView.session.currentFrame else {  print("Can't get current frame. Now is \(sessionState).");return }
        
        let accleration = motionManager.accelerometerData!.acceleration
        let acclerationValue = Float(accleration3Value(accleration))
        
        if acclerationValue > 2 {
            let ballNode = sceneView.scene.rootNode.childNode(withName: "ball", recursively: true)!
            let cameraTransform = SCNMatrix4(currentFrame.camera.transform)
            let force = SCNVector3(-cameraTransform.m31 * acclerationValue, -cameraTransform.m32 * acclerationValue, -cameraTransform.m33 * acclerationValue)
            ballNode.transform = cameraTransform
            rightHand.removeAllPhysicShape()
            ballNode.physicsBody = .dynamic()
            ballNode.physicsBody!.applyForce(force, asImpulse: true)
            motionManager.stopAccelerometerUpdates()
            timer.invalidate()
            sessionState = .ballIsThrewOut
        }
    }
}
