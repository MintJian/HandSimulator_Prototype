//
//  RightHandInitHelper.swift
//  ARHandSimulatorFever
//
//  Created by Kagamigawa on 2020/04/22.
//  Copyright © 2020 JohnBo. All rights reserved.
//

import SceneKit
import GLKit

extension RightHand {
    struct RotationLimits {
        var up: Float = 0
        var down: Float = 0
    }
    
    private func fingerRotateUpEulerAngle(of joint:SCNNode, theta: Float) -> SCNVector3 {
        var willsRotate = joint.eulerAngles
        willsRotate.z += theta
        return willsRotate
    }
    private func fingerRotateDownEulerAngle(of joint:SCNNode, theta: Float) -> SCNVector3 {
        var willsRotate = joint.eulerAngles
        willsRotate.z -= theta
        return willsRotate
    }
    
    private func thumbMetacarpalBoneRotateUpEulerAngle(of joint:SCNNode, theta: Float) -> SCNVector3 {
        var willsRotate = joint.eulerAngles
        willsRotate.x += theta
        return willsRotate
    }
    
    private func thumbMetacarpalBoneRotateDownEulerAngle(of joint:SCNNode, theta: Float) -> SCNVector3 {
        var willsRotate = joint.eulerAngles
        willsRotate.x -= theta
        return willsRotate
    }
    
    func middleFingerRootJointRotateUp() {
        let name = "middleFingerRootJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateUpEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z < getFingerRotationLimits(of: name)!.up {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
    }
    func middleFingerMidJointRotateUp() {
        let name = "middleFingerMidJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateUpEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z < getFingerRotationLimits(of: name)!.up {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
        
    }
    func middleFingerTerminalJointRotateUp() {
        let name = "middleFingerTerminalJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateUpEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z < getFingerRotationLimits(of: name)!.up {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
    }
    func indexFingerRootJointRotateUp() {
        let name = "indexFingerRootJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateUpEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z < getFingerRotationLimits(of: name)!.up {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
        
    }
    func indexFingerMidJointRotateUp() {
        let name = "indexFingerMidJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateUpEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z < getFingerRotationLimits(of: name)!.up {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
        
    }
    func indexFingerTerminalJointRotateUp() {
        let name = "indexFingerTerminalJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateUpEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z < getFingerRotationLimits(of: name)!.up {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
        
    }
    func ringFingerRootJointRotateUp() {
        let name = "ringFingerRootJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateUpEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z < getFingerRotationLimits(of: name)!.up {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
        
    }
    func ringFingerMidJointRotateUp() {
        let name = "ringFingerMidJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateUpEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z < getFingerRotationLimits(of: name)!.up {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
        
    }
    func ringFingerTerminalJointRotateUp() {
        let name = "ringFingerTerminalJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateUpEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z < getFingerRotationLimits(of: name)!.up {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
        
    }
    func littleFingerRootJointRotateUp() {
        let name = "littleFingerRootJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateUpEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z < getFingerRotationLimits(of: name)!.up {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
    }
    func littleFingerMidJointRotateUp() {
        let name = "littleFingerMidJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateUpEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z < getFingerRotationLimits(of: name)!.up {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
    }
    func littleFingerTerminalJointRotateUp() {
        let name = "littleFingerTerminalJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateUpEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z < getFingerRotationLimits(of: name)!.up {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
    }
    func thumbRootJointRotateUp() {
        let name = "thumbRootJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateUpEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z < getFingerRotationLimits(of: name)!.up {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
    }
    func thumbTerminalJointRotateUp() {
        let name = "thumbTerminalJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateUpEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z < getFingerRotationLimits(of: name)!.up {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
    }
    func thumbMetacarpalBoneRootJointRotateUp() {
        let name = "thumbPalmBoneRootJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = thumbMetacarpalBoneRotateUpEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.x < Float.pi * (2 / 3) {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
    }
    
    //
    
    func middleFingerRootJointRotateDown() {
        let name = "middleFingerRootJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateDownEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z > getFingerRotationLimits(of: name)!.down {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
    }
    func middleFingerMidJointRotateDown() {
        let name = "middleFingerMidJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateDownEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z > getFingerRotationLimits(of: name)!.down {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
        
    }
    func middleFingerTerminalJointRotateDown() {
        let name = "middleFingerTerminalJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateDownEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z > getFingerRotationLimits(of: name)!.down {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
    }
    func indexFingerRootJointRotateDown() {
        let name = "indexFingerRootJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateDownEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z > getFingerRotationLimits(of: name)!.down {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
        
    }
    func indexFingerMidJointRotateDown() {
        let name = "indexFingerMidJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateDownEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z > getFingerRotationLimits(of: name)!.down {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
        
    }
    func indexFingerTerminalJointRotateDown() {
        let name = "indexFingerTerminalJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateDownEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z > getFingerRotationLimits(of: name)!.down {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
        
    }
    func ringFingerRootJointRotateDown() {
        let name = "ringFingerRootJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateDownEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z > getFingerRotationLimits(of: name)!.down {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
        
    }
    func ringFingerMidJointRotateDown() {
        let name = "ringFingerMidJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateDownEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z > getFingerRotationLimits(of: name)!.down {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
        
    }
    func ringFingerTerminalJointRotateDown() {
        let name = "ringFingerTerminalJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateDownEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z > getFingerRotationLimits(of: name)!.down {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
        
    }
    func littleFingerRootJointRotateDown() {
        let name = "littleFingerRootJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateDownEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z > getFingerRotationLimits(of: name)!.down {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
    }
    func littleFingerMidJointRotateDown() {
        let name = "littleFingerMidJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateDownEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z > getFingerRotationLimits(of: name)!.down {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
    }
    func littleFingerTerminalJointRotateDown() {
        let name = "littleFingerTerminalJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateDownEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z > getFingerRotationLimits(of: name)!.down {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
    }
    func thumbRootJointRotateDown() {
        let name = "thumbRootJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateDownEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z > getFingerRotationLimits(of: name)!.down {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
    }
    func thumbTerminalJointRotateDown() {
        let name = "thumbTerminalJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = fingerRotateDownEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.z > getFingerRotationLimits(of: name)!.down {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
    }
    func thumbMetacarpalBoneRootJointRotateDown() {
        let name = "thumbPalmBoneRootJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else {print("can't find joint"); return}
        let rotateResult = thumbMetacarpalBoneRotateDownEulerAngle(of: joint, theta: rotatePerMove)
        
        if rotateResult.x > Float.pi / 6 {
            joint.eulerAngles = rotateResult
            //print(rotateResult)
        }
    }
    
    //
    
    func handJointRotateUp() {
        let joint = controlRoot
        
        let orientation = joint.orientation
        let multiplier = GLKQuaternionMakeWithAngleAndAxis(rotatePerMove, 0, 0, 1)
        var glk = GLKQuaternionMake(orientation.x, orientation.y, orientation.z, orientation.w)
        glk = GLKQuaternionMultiply(glk, multiplier)
        joint.orientation = SCNQuaternion(glk.x, glk.y, glk.z, glk.w)
    }
    func handJointRotateDown() {
        let joint = controlRoot
        
        let orientation = joint.orientation
        let multiplier = GLKQuaternionMakeWithAngleAndAxis(-rotatePerMove, 0, 0, 1)
        var glk = GLKQuaternionMake(orientation.x, orientation.y, orientation.z, orientation.w)
        glk = GLKQuaternionMultiply(glk, multiplier)
        joint.orientation = SCNQuaternion(glk.x, glk.y, glk.z, glk.w)
    }
    func handJointRotateLeft() {
        let joint = controlRoot
        
        let orientation = joint.orientation
        let multiplier = GLKQuaternionMakeWithAngleAndAxis(rotatePerMove, 0, 1, 0)
        var glk = GLKQuaternionMake(orientation.x, orientation.y, orientation.z, orientation.w)
        glk = GLKQuaternionMultiply(glk, multiplier)
        joint.orientation = SCNQuaternion(glk.x, glk.y, glk.z, glk.w)
    }
    func handJointRotateRight() {
        let joint = controlRoot
        
        let orientation = joint.orientation
        let multiplier = GLKQuaternionMakeWithAngleAndAxis(-rotatePerMove, 0, 1, 0)
        var glk = GLKQuaternionMake(orientation.x, orientation.y, orientation.z, orientation.w)
        glk = GLKQuaternionMultiply(glk, multiplier)
        joint.orientation = SCNQuaternion(glk.x, glk.y, glk.z, glk.w)
    }
    
    func handJointSelfRotateRight() {
        let joint = controlRoot
        
        let orientation = joint.orientation
        let multiplier = GLKQuaternionMakeWithAngleAndAxis(-rotatePerMove, 1, 0, 0)
        var glk = GLKQuaternionMake(orientation.x, orientation.y, orientation.z, orientation.w)
        glk = GLKQuaternionMultiply(glk, multiplier)
        joint.orientation = SCNQuaternion(glk.x, glk.y, glk.z, glk.w)
    }
    func handJointSelfRotateLeft() {
        let joint = controlRoot
        
        let orientation = joint.orientation
        let multiplier = GLKQuaternionMakeWithAngleAndAxis(rotatePerMove, 1, 0, 0)
        var glk = GLKQuaternionMake(orientation.x, orientation.y, orientation.z, orientation.w)
        glk = GLKQuaternionMultiply(glk, multiplier)
        joint.orientation = SCNQuaternion(glk.x, glk.y, glk.z, glk.w)
    }
    
    func wristJointRotateUp() {
        let name = "wristJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else { print("can not find \(name)."); return }
        
        if joint.eulerAngles.z + rotatePerMove <= Float.pi / 2 {
            joint.eulerAngles.z += rotatePerMove
        }
    }
    func wristJointRotateDown() {
        let name = "wristJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else { print("can not find \(name)."); return }
        
        if joint.eulerAngles.z - rotatePerMove >= -Float.pi / 2 {
            joint.eulerAngles.z -= rotatePerMove
        }
        
    }
    func wristJointRotateLeft() {
        let name = "wristJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else { print("can not find \(name)."); return }
        
        if joint.eulerAngles.y + rotatePerMove <= Float.pi / 4 {
            joint.eulerAngles.y += rotatePerMove
        }
        
    }
    func wristJointRotateRight() {
        let name = "wristJoint"
        guard let joint = controlRoot.childNode(withName: name, recursively: true) else { print("can not find \(name)."); return }
        
        if joint.eulerAngles.y - rotatePerMove >= -Float.pi / 4 {
            joint.eulerAngles.y -= rotatePerMove
        }
        
    }
    
    func handMoveForward() {
        let joint = controlRoot
        
        joint.position.z -= distancePerMove
    }
    func handMoveBack() {
        let joint = controlRoot
        
        joint.position.z += distancePerMove
    }
    func handMoveLeft(){
        let joint = controlRoot
        
        joint.position.x -= distancePerMove
    }
    func handMoveRight(){
        let joint = controlRoot
        
        joint.position.x += distancePerMove
    }
    func handMoveUp(){
        let joint = controlRoot
        
        joint.position.y += distancePerMove
    }
    func handMoveDown() {
        let joint = controlRoot
        
        joint.position.y -= distancePerMove
    }
}
