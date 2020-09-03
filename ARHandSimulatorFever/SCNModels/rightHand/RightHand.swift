//
//  RightHand.swift
//  ARHandSimulatorFever
//
//  Created by Kagamigawa on 2020/04/22.
//  Copyright © 2020 JohnBo. All rights reserved.
//

import SceneKit

class RightHand {
    private var enable:Bool = false
    private var controlRootEditable = SCNNode()
    private var modelRootEditable = SCNNode()
    private var handRotateLimitsDictionary:[String : RotationLimits] = [:]
    let rotatePerMove = 5.0 * (Float.pi / 180.0)
    let distancePerMove:Float = 0.01
    
    var controlRoot: SCNNode {
        get {
            return controlRootEditable
        }
    }
    var modelRoot: SCNNode {
        get {
            return modelRootEditable
        }
    }
    
    init() {
        enable = false
    }
    
    init(targetNode: SCNNode) {
        enable = true
        guard let defaultScene = SCNScene(named: "art.scnassets/models/rightHandModel.scn") else { print("Right hand model source file is lost."); return}
        
        let originalNode = defaultScene.rootNode.clone()
        targetNode.addChildNode(originalNode)
        guard let controlNode = targetNode.childNode(withName: "armJoint", recursively: true) else { print("Node adding error."); return}
        guard let modelNode = targetNode.childNode(withName: "rightHandModel", recursively: true) else { print("Node adding error."); return}
        
        
        controlRootEditable = controlNode
        modelRootEditable = modelNode
        modelRoot.physicsBody = nil
        controlRootEditable.physicsBody = nil
        configurePhysicsShape(root: controlRootEditable.parent!)
        configureDistionary()
    }
    
    func reset(at position: SCNVector3) {
        makeAllJointRotateUpMax()
        controlRoot.orientation = SCNQuaternion(0, 0, 0, 0)
        controlRoot.position = position
    }
    
    func makeAllJointRotateUpMax() {
        for i in handRotateLimitsDictionary {
            let node = controlRoot.childNode(withName: i.key, recursively: true)!
            if i.key == "thumbPalmBoneRootJoint" {
                node.eulerAngles.x = i.value.up
            }
            node.eulerAngles.z = i.value.up
        }
        
    }
    
       func isFingerEulerMax(_ joint: SCNNode, _ withUp: Bool) -> Bool {
            let limit = handRotateLimitsDictionary[joint.name!]!
            let eulerZ = joint.eulerAngles.z
            return withUp ? eulerZ == limit.up : eulerZ == limit.down
        }
        
        func getFingerRotationLimits(of name: String) -> RotationLimits? {
            if !enable { return nil }
            return handRotateLimitsDictionary[name]
        }
        
        func middleFingerSelfRotateUp() {
            if !enable { return }
            middleFingerMidJointRotateUp()
            middleFingerTerminalJointRotateUp()
        }
        func ringFingerSelfRotateUp() {
            if !enable { return }
            ringFingerMidJointRotateUp()
            ringFingerTerminalJointRotateUp()
        }
        func indexFingerSelfRotateUp() {
            if !enable { return }
            indexFingerMidJointRotateUp()
            indexFingerTerminalJointRotateUp()
        }
        func littleFingerSelfRotateUp() {
            if !enable { return }
            littleFingerMidJointRotateUp()
            littleFingerTerminalJointRotateUp()
        }
        func thumbSelfRotateUp() {
            if !enable { return }
            thumbTerminalJointRotateUp()
        }
        
        func middleFingerSelfRotateDown() {
            if !enable { return }
            middleFingerMidJointRotateDown()
            middleFingerTerminalJointRotateDown()
        }
        func ringFingerSelfRotateDown() {
            if !enable { return }
            ringFingerMidJointRotateDown()
            ringFingerTerminalJointRotateDown()
        }
        func indexFingerSelfRotateDown() {
            if !enable { return }
            indexFingerMidJointRotateDown()
            indexFingerTerminalJointRotateDown()
        }
        func littleFingerSelfRotateDown() {
            if !enable { return }
            littleFingerMidJointRotateDown()
            littleFingerTerminalJointRotateDown()
        }
        func thumbSelfRotateDown() {
            if !enable { return }
            thumbTerminalJointRotateDown()
        }
        
        
        func middleFingerRootRotateUp() {
            if !enable { return }
            middleFingerRootJointRotateUp()
        }
        func ringFingerRootRotateUp() {
            if !enable { return }
            ringFingerRootJointRotateUp()
        }
        func indexFingerRootRotateUp() {
            if !enable { return }
            indexFingerRootJointRotateUp()
        }
        func littleFingerRootRotateUp() {
            if !enable { return }
            littleFingerRootJointRotateUp()
        }
        func thumbRootRotateUp() {
            if !enable { return }
            thumbRootJointRotateUp()
        }
        
        func middleFingerRootRotateDown() {
            if !enable { return }
            middleFingerRootJointRotateDown()
        }
        func ringFingerRootRotateDown() {
            if !enable { return }
            ringFingerRootJointRotateDown()
        }
        func indexFingerRootRotateDown() {
            if !enable { return }
            indexFingerRootJointRotateDown()
        }
        func littleFingerRootRotateDown() {
            if !enable { return }
            littleFingerRootJointRotateDown()
        }
        func thumbRootRotateDown() {
            if !enable { return }
            thumbRootJointRotateDown()
        }
        
        func thumbBoneRotateUp() {
            if !enable { return }
            thumbMetacarpalBoneRootJointRotateUp()
        }
        func thumbBoneRotateDown() {
            if !enable { return }
            thumbMetacarpalBoneRootJointRotateDown()
        }
        
        private func configureDistionary() {
            let fingerNames = ["thumb","indexFinger", "middleFinger", "ringFinger", "littleFinger"]
            let fingerJointPartNames = ["Root", "Mid", "Terminal"]
            let jointNames = "Joint"
            
            for finger in fingerNames {
                for part in fingerJointPartNames {
                    if finger == "thumb" && part == "Mid" {
                        continue
                    }
                let node = controlRoot.childNode(withName: finger + part + jointNames, recursively: true)!
                var rotationLimits = RotationLimits()
                rotationLimits.up = node.eulerAngles.z
                rotationLimits.down = node.eulerAngles.z - (Float.pi / 2.0)
                
                handRotateLimitsDictionary.updateValue(rotationLimits, forKey: finger + part + jointNames)
                }
            }
            
            let thumbPalmBoneRootJoint = controlRoot.childNode(withName: "thumbPalmBoneRootJoint", recursively: true)!
            var rotationLimits = RotationLimits()
            rotationLimits.up = thumbPalmBoneRootJoint.eulerAngles.x
            rotationLimits.down = thumbPalmBoneRootJoint.eulerAngles.x - (Float.pi / 2.0)
            handRotateLimitsDictionary.updateValue(rotationLimits, forKey: "thumbPalmBoneRootJoint")
        }
        
            func configurePhysicsShape(root: SCNNode) {
                if root.childNodes.count == 0 {
                    return
                }
                for i in root.childNodes {
                    if i.geometry is SCNCylinder {
        //                i.physicsBody!.physicsShape = SCNPhysicsShape(node: i, options: [SCNPhysicsShape.Option.scale: i.scale])
                        i.physicsBody!.physicsShape = SCNPhysicsShape(geometry: i.geometry!, options: [SCNPhysicsShape.Option.scale: i.scale])
                    } else {
                        i.physicsBody = nil
                    }
                    configurePhysicsShape(root: i)
                }
            }
        
        func removeAllPhysicShape() {
            removeAllPhysicShapeFromControl(root: controlRoot)
        }
            
        
            private func removeAllPhysicShapeFromControl(root: SCNNode) {
                    if root.childNodes.count == 0 {
                        return
                    }
                    for i in root.childNodes {
                        if i.geometry is SCNCylinder {
            //                i.physicsBody!.physicsShape = SCNPhysicsShape(node: i, options: [SCNPhysicsShape.Option.scale: i.scale])
                            i.physicsBody!.physicsShape = .none
                        } else {
                            i.physicsBody = nil
                        }
                        configurePhysicsShape(root: i)
                    }
                }
        
        func point(at target:SCNVector3) {
            controlRoot.position = controlRoot.presentation.position
            controlRoot.look(at: target)
        }
        
    }
