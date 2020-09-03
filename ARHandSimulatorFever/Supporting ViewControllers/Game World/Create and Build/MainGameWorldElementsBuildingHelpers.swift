//
//  GameWorldBuildingHelpers.swift
//  ARHandSimulatorFever
//
//  Created by Kagamigawa on 2020/05/06.
//  Copyright © 2020 JohnBo. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

extension MainViewController {
    
    func createFloor(at worldPosition: SCNVector3) {
        let floor = SCNNode()
        let geometry = SCNFloor()
        floor.geometry = geometry
        floor.position = worldPosition
        floor.physicsBody = .static()
        floor.physicsBody!.friction = 2.1
        floor.physicsBody!.rollingFriction = 2
        floor.opacity = 0
        sceneView.scene.rootNode.addChildNode(floor)
    }
    
    func createDetecingPlane(planeAnchor: ARPlaneAnchor) -> SCNNode {
        let plane = SCNNode()
        let geometry = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        
        geometry.firstMaterial!.diffuse.contents = UIColor.white
        plane.geometry = geometry
        plane.opacity = 0.4
        plane.eulerAngles.x -= Float.pi / 2.0
        plane.position = SCNVector3(planeAnchor.center.x, 0,planeAnchor.center.z)
        plane.name = "detectedPlane"
        
        return plane
    }
    
    func buildPreViewGameBoard(at origin: SCNVector3) -> SCNNode {
        let gameBoardPreViewNode = SCNNode()
        
        let oldNode = sceneView.scene.rootNode.childNode(withName: "gameBoardPreView", recursively: true)
        if oldNode != nil {
            oldNode!.removeFromParentNode()
        }
        
        let geometry = SCNCylinder(radius: 0.25, height: 0.01)
        geometry.name = "gameBoardPreView"
        geometry.firstMaterial!.diffuse.contents = UIColor.black
        gameBoardPreViewNode.geometry = geometry
        gameBoardPreViewNode.opacity = 0.5
        gameBoardPreViewNode.position.x = origin.x
        gameBoardPreViewNode.position.y = origin.y
        gameBoardPreViewNode.position.z = origin.z
        
        
        return gameBoardPreViewNode
    }
    
    func buildEdgeOnGameBoard() {
        let edge = SCNNode()
        
        let geometryOfTube = SCNTube(innerRadius: 0.23, outerRadius: 0.25, height: 0.03)
        geometryOfTube.firstMaterial!.diffuse.contents = UIColor.white
        edge.geometry = geometryOfTube
        edge.position = SCNVector3(0,0.02,0)
        mainGameBoard.physicsBody = .kinematic()
        mainGameBoard.physicsBody!.rollingFriction = 5
        mainGameBoard.physicsBody!.friction = 5.5
        
        edge.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(node: edge, options: [SCNPhysicsShape.Option.type :SCNPhysicsShape.ShapeType.concavePolyhedron]))
        mainGameBoard.addChildNode(edge)
        
        mainGameBoard.geometry!.firstMaterial?.lightingModel = .lambert
        
        sessionState = .buildingWorld
    }
    
    func buildTheWorld() {
        guard sessionState == .buildingWorld else { print("error in building world, now is \(sessionState)"); return}
        
        configureHandModel(to: sceneView.scene)
        
        sessionState = .gameInProgress
        
        buildWorldOne()
        
        configureImageClassifyTimer()
    }
    
    
    func buildWorldOne() {
        let ball = SCNNode()
        
        let geometry = SCNSphere(radius: 0.05)
        geometry.firstMaterial!.diffuse.contents = UIColor.cyan
        geometry.firstMaterial!.lightingModel = .blinn
        ball.geometry = geometry
        ball.name = "ball"
        ball.position = mainGameBoard.position
        ball.physicsBody = .dynamic()
        ball.physicsBody!.contactTestBitMask = ballAndHandContactMask
        ball.position.y += 0.1
        ball.physicsBody!.rollingFriction = 0.8
        ball.physicsBody!.friction = 1
        ball.physicsBody!.mass = 5
        sceneView.scene.rootNode.addChildNode(ball)
        sessionState = .cachingThings
    }
}
