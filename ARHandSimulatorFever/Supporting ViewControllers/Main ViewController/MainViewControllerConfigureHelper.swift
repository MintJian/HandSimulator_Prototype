//
//  MainViewControllerConfigureHelper.swift
//  ARHandSimulatorFever
//
//  Created by Kagamigawa on 2020/05/06.
//  Copyright © 2020 JohnBo. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

extension MainViewController {
    func configureMainStage() {
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/mainStage/MainStage.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        sceneView.scene.physicsWorld.contactDelegate = self
        
        mainGameBoard = buildPreViewGameBoard(at: SCNVector3(0,0,0))
        mainGameBoard.isHidden = true
        mainGameBoard.name = nil
        previewPlane.name = nil
        sceneView.scene.rootNode.addChildNode(mainGameBoard)
    }
    
    func configureHandModel(to: SCNScene) {
        rightHand = RightHand(targetNode: sceneView.scene.rootNode)
        rightHand.controlRoot.position = mainGameBoard.position
        rightHand.controlRoot.position.y += 0.3
        //        print(rightHand.controlRoot.position)
        handControlManager = HandControlManager(handControlRoot: &rightHand, sessionState: sessionState, menuStatus: menuStatus, debugMode: debugMode)
    }
    
    func configureView() {
        var debugOptions: SCNDebugOptions = []
        
        sceneView.autoenablesDefaultLighting = true
        
        // Show statistics such as fps and timing information
//        sceneView.showsStatistics = true
        // fix the scaling of the physics debug view to match the world
        //        debugOptions.insert(.showPhysicsShapes)
        
        //debugOptions.insert(ARSCNDebugOptions.showWorldOrigin)
        
        // show where ARKit is detecting feature points
        //debugOptions.insert(ARSCNDebugOptions.showFeaturePoints)
        
        sceneView.debugOptions = debugOptions
        
        //        handDebugModeOn()
        configureHandPartsCollectionView()
        configureMoveMethodsCollectionView()
    }
    
    func configureHandPartsCollectionView() {
        //        handPartsCollectionView = HandPartsCollectionView()
        handPartsCollectionView.loadViewIfNeeded()
        handPartsCollectionView.handPartNameArray = []
        self.view.addSubview(handPartsCollectionView.collectionView!)
    }
    

        func configureMoveMethodsCollectionView() {
    //        moveMethodsCollectionView = MoveMethodsCollectionView()
            moveMethodsCollectionView.loadViewIfNeeded()
            moveMethodsCollectionView.moveMethodNameArray = []
            self.view.addSubview(moveMethodsCollectionView.collectionView!)
        }
        
        func configureARSession() {
            let configuration = ARWorldTrackingConfiguration()
            configuration.isAutoFocusEnabled = true
            configuration.worldAlignment = .gravity
            //真实光线评估
            configuration.isLightEstimationEnabled = false
            configuration.planeDetection = .horizontal
            
            print("AR session configured")
            
            sceneView.session.run(configuration)
        }
    
    func configureImageClassifyTimer() {
        imageClassifyTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(classifyHandGesture), userInfo: nil, repeats: true)
        RunLoop.current.add(imageClassifyTimer, forMode: .common)
        imageClassifyTimer.fire()
    }
}
