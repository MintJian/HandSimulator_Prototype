//
//  ViewController.swift
//  ARHandSimulatorFever
//
//  Created by Kagamigawa on 2020/04/21.
//  Copyright © 2020 JohnBo. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import CoreMotion
import Vision

class MainViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate {
    
    @IBOutlet weak var debugModeSwitch: UISwitch!
    
    @IBOutlet var sceneView: ARSCNView!
    //    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    //States Informations
    @IBOutlet weak var trackingStateLabel: UILabel!
    
    @IBOutlet weak var acceptGameBoardButton: UIButton!
    
    var previewPlane = SCNNode()
    var mainGameBoard = SCNNode()
    var rightHand = RightHand()
    var terminalFingersTouched: [String : Bool] = [ "thumbTerminalShape" : false , "indexFingerTerminalShape" : false, "middleFingerTerminalShape" : false, "ringFingerTerminalShape": false, "littleFingerTerminalShape" : false]
    
    var handPartsCollectionView = HandPartsCollectionView()
    var moveMethodsCollectionView = MoveMethodsCollectionView()
    
    var nowHandPartArray: [HandPartFlag] = []
    var nowActionArray: [ActionFlag] = []
    
    var handControlManager: HandControlManager!
    
    var handGesture: HandGesture = .none {
        didSet {
            trackingStateLabel.isHidden = false
            if menuStatus != .readyToUse {
                updateCollectionView(with: handGesture)
            } else {
                menuStatus = .close
            }
            print("hand gesture is \(handGesture) now.")
            trackingStateLabel.text = "当前手势是\(handGesture)"
            if handGesture == .go && menuStatus == .close {
                if !nowHandPartArray.isEmpty && !nowActionArray.isEmpty {
                    handControlManager.make(nowHandPartArray.first!, nowActionArray.first!)
                }
            }
        }
    }
    
    var selectedCollectionView: SelectedCollectionView = .handPart {
        didSet {
            guard oldValue != selectedCollectionView else { return }
            print("\(selectedCollectionView) collection view is selected.")
        }
    }
    
    var sessionState: SessionState = .setup {
        didSet {
            guard oldValue != sessionState else { return }
            print("session state changed to \(sessionState)")
        }
    }
    
    var menuStatus: MenuStatus = .readyToUse {
        didSet {
            guard oldValue != menuStatus else { return }
            print("menu status changed to \(menuStatus)")
        }
    }
    
    var debugMode: DebugMode = .off {
        didSet {
            guard oldValue != debugMode else { return }
            print("debug mode is \(debugMode)")
        }
    }
    
    var motionManager = CMMotionManager()
    var accelratorTimer = Timer()
    var imageClassifyTimer = Timer()
    
    /// - Tag: MLModelSetup
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: HandGestureClassify().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    func preSetUIControl() {
        acceptGameBoardButton.isHidden = true
        trackingStateLabel.isHidden = true
        trackingStateLabel.font = UIFont.boldSystemFont(ofSize: 17)
        debugModeSwitch.isHidden = true
        view.bringSubviewToFront(sceneView)
        view.bringSubviewToFront(trackingStateLabel)
        view.bringSubviewToFront(acceptGameBoardButton)
    }
    
    
    func getReadyToFindPlane() {
        sessionState = .lookingForSurface
        trackingStateLabel.text = "请移动相机，来寻找合适的平面，通过点击屏幕来放置游戏板。"
        trackingStateLabel.textColor = UIColor.white
        trackingStateLabel.numberOfLines = 0
        trackingStateLabel.isHidden = false
    }
    
    @objc
    func tapped(_ sender: UITapGestureRecognizer) {
        autoreleasepool {
            if (sessionState == .lookingForSurface || sessionState == .placingBoard) && sceneView.scene.rootNode.childNode(withName: "detectedPlane", recursively: true) != nil {
                sessionState = .placingBoard
                acceptGameBoardButton.setTitle("  放置  ", for: UIControl.State.normal)
                acceptGameBoardButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 17)
                acceptGameBoardButton.isHidden = false
                
                
                let touchLocation = sender.location(in: sceneView)
                let hitTestResult = sceneView.hitTest(touchLocation, types: [.existingPlaneUsingExtent])
                
                if let result = hitTestResult.first {
                    let preProcessColumns = result.worldTransform.columns.3
                    mainGameBoard.position = SCNVector3(preProcessColumns.x, preProcessColumns.y, preProcessColumns.z)
                    
                    if mainGameBoard.isHidden == true {
                        mainGameBoard.isHidden = false
                    }
                    if mainGameBoard.name == nil {
                        mainGameBoard.name = "mainGameBoardPreview"
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestures = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        tapGestures.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGestures)
        // Set the view's delegate
        sceneView.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureMainStage()
        configureView()
        configureARSession()
        preSetUIControl()
        getReadyToFindPlane()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    @IBAction func debugModeSwitchTapped(_ sender: UISwitch) {
        switch sender.isOn {
        case false:
            
            break
        default:
            
            break
        }
    }
    
    //    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
    //        if (sessionState == .lookingForSurface || sessionState == .placingBoard) && sceneView.scene.rootNode.childNode(withName: "detectedPlane", recursively: true) != nil {
    //            sessionState = .placingBoard
    //            acceptGameBoardButton.setTitle("  放置  ", for: UIControl.State.normal)
    //            acceptGameBoardButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 17)
    //            acceptGameBoardButton.isHidden = false
    //
    //            let touchLocation = sender.location(in: sceneView)
    //            let hitTestResult = sceneView.hitTest(touchLocation, types: [.existingPlaneUsingExtent])
    //
    //            if let result = hitTestResult.first {
    //                let preProcessColumns = result.worldTransform.columns.3
    //                mainGameBoard.position = SCNVector3(preProcessColumns.x, preProcessColumns.y, preProcessColumns.z)
    //
    //                if mainGameBoard.isHidden == true {
    //                    mainGameBoard.isHidden = false
    //                }
    //                if mainGameBoard.name == nil {
    //                    mainGameBoard.name = "mainGameBoardPreview"
    //                }
    //            }
    //        }
    //
    //    }
    
    func handDebugModeOn() {
        debugModeSwitch.isOn = false
    }
    
    @IBAction func acceptButtonPressed(_ sender: UIButton) {
        guard sessionState == .placingBoard else {print("Error state! Now state is \(sessionState)"); return }
        if mainGameBoard.name == nil { print("No gameBoardPreView node.");print(sceneView.scene.rootNode.childNodes); return}
        
        if previewPlane.name == nil {print("No preview plane."); return }
        
        mainGameBoard.opacity = 1
        mainGameBoard.name = "mainGameBoard"
        
        
        previewPlane.removeFromParentNode()
        previewPlane.isHidden = true
        acceptGameBoardButton.isHidden = true
        trackingStateLabel.isHidden = true
        
        var floorPostion = mainGameBoard.worldPosition
        floorPostion.y -= 0.01
        createFloor(at: floorPostion)
        buildEdgeOnGameBoard()
        view.bringSubviewToFront(handPartsCollectionView.collectionView!)
        view.bringSubviewToFront(moveMethodsCollectionView.collectionView!)
        view.bringSubviewToFront(trackingStateLabel)
        
        buildTheWorld()
    }
    
    // MARK: - PhysicsWorldDelegate
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        
        if sessionState == .cachingThings {
            let terminalFingersNames: [String] = [ "thumbTerminalShape","indexFingerTerminalShape","middleFingerTerminalShape","ringFingerTerminalShape","littleFingerTerminalShape"]
            
            let nodeA = contact.nodeA
            let nodeB = contact.nodeB
            
            if nodeA.name == "ball" && terminalFingersNames.contains(nodeB.name ?? "nil") {
                terminalFingersTouched[nodeB.name!]! = true
                
            }
            if nodeB.name == "ball" && terminalFingersNames.contains(nodeA.name ?? "nil") {
                terminalFingersTouched[nodeA.name!]! = true
            }
            
            var nowFingers = [String]()
            for i in terminalFingersTouched {
                if i.value == true {
                    nowFingers.append(i.key)
                }
            }
            
            if nowFingers.count >= 2 {
                for i in 0...nowFingers.count - 2 {
                    let node1 = rightHand.controlRoot.childNode(withName: nowFingers[i], recursively: true)!
                    let node1Position = SCNVector3(node1.presentation.worldPosition.x, node1.presentation.worldPosition.y, node1.presentation.worldPosition.z)
                    for j in 1...nowFingers.count - 1 {
                        let node2 = rightHand.controlRoot.childNode(withName: nowFingers[j], recursively: true)!
                        let node2Position = SCNVector3(node2.presentation.worldPosition.x, node2.presentation.worldPosition.y, node2.presentation.worldPosition.z)
                        
                        if distance(node1Position, node2Position) >= 0.07 {
                            let ballNode = sceneView.scene.rootNode.childNode(withName: "ball", recursively: true)!
                            
                            let position = ballNode.presentation.worldPosition
                            ballNode.removeFromParentNode()
                            ballNode.physicsBody = .static()
                            rightHand.controlRoot.addChildNode(ballNode)
                            //                        ballNode.position = SCNVector3(0.102,-0.05,0)
                            ballNode.worldPosition = position
                            motionManager.startAccelerometerUpdates()
                            motionManager.accelerometerUpdateInterval = 0.01
                            
                            accelratorTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector:  #selector(throwBall), userInfo: nil, repeats: true)
                            RunLoop.current.add(accelratorTimer, forMode: .common)
                            accelratorTimer.fire()
                            sessionState = .readyToThrowOut
                        }
                    }
                }
            }
        }
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact) {
        
        if sessionState == .cachingThings {
            let terminalFingersNames: [String] = [ "thumbTerminalShape","indexFingerTerminalShape","middleFingerTerminalShape","ringFingerTerminalShape","littleFingerTerminalShape"]
            
            let nodeA = contact.nodeA
            let nodeB = contact.nodeB
            
            if nodeA.name == "ball" && terminalFingersNames.contains(nodeB.name ?? "nil") {
                terminalFingersTouched[nodeB.name!]! = false
            }
            if nodeB.name == "ball" && terminalFingersNames.contains(nodeA.name ?? "nil") {
                terminalFingersTouched[nodeA.name!]! = false
            }
        }
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if sessionState == .ballIsThrewOut {
            let ballNode = sceneView.scene.rootNode.childNode(withName: "ball", recursively: true)!
            rightHand.point(at: ballNode.presentation.worldPosition)
            sessionState = .stageClear
            
            if accelratorTimer.isValid {
                accelratorTimer.invalidate()
            }
            
            if imageClassifyTimer.isValid {
                imageClassifyTimer.invalidate()
            }
        }
    }
    
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if sessionState == .lookingForSurface {
            guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
            
            if planeAnchor.extent.x < 0.3 || planeAnchor.extent.z < 0.3 {
                return
            }
            
            let newPlane = createDetecingPlane(planeAnchor: planeAnchor)
            let existPlane = node.childNode(withName: "detectedPlane", recursively: false)
            
            if existPlane == nil {
                node.addChildNode(newPlane)
                previewPlane = newPlane
                //                print("Found a plane.")
            } else {
                guard let oldBoardGeometry = existPlane!.geometry as? SCNPlane else { print("gameBoard is not SCNBox"); return }
                guard let newBoardGeometry = newPlane.geometry as? SCNPlane else { print("gameBoard is not SCNBox"); return }
                
                let oldVolume = oldBoardGeometry.height * oldBoardGeometry.width
                let newVolume = newBoardGeometry.height * newBoardGeometry.width
                
                if oldVolume < newVolume {
                    existPlane!.removeFromParentNode()
                    node.addChildNode(newPlane)
                    //                    print("Updated a plane")
                    previewPlane = newPlane
                }
            }
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
