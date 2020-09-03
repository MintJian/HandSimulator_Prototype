//
//  HandControlManagerConvertFlagToFuncHelper.swift
//  ARHandSimulatorFever
//
//  Created by Kagamigawa on 2020/04/28.
//  Copyright © 2020 JohnBo. All rights reserved.
//

import Foundation


func convertEnumToFunc(handControlRoot: inout RightHand, _ handPart: HandPartFlag, _ action: ActionFlag) {
    switch handPart {
    case .tRoot:
        switch action {
        case .rUp:
            handControlRoot.thumbRootRotateUp()
        case .rDown:
            handControlRoot.thumbRootRotateDown()
        default:
            print("\(handPart) \(action) is in valid.")
            break
        }
    case .iRoot:
        
        switch action {
        case .rUp:
            handControlRoot.indexFingerRootRotateUp()
        case .rDown:
            handControlRoot.indexFingerRootRotateDown()
        default:
            print("\(handPart) \(action) is in valid.")
            break
        }
    case .mRoot:
        
        switch action {
        case .rUp:
            handControlRoot.middleFingerRootRotateUp()
        case .rDown:
            handControlRoot.middleFingerRootRotateDown()
        default:
            print("\(handPart) \(action) is in valid.")
            break
        }
    case .rRoot:
        
        switch action {
        case .rUp:
            handControlRoot.ringFingerRootRotateUp()
        case .rDown:
            handControlRoot.ringFingerRootRotateDown()
        default:
            print("\(handPart) \(action) is in valid.")
            break
        }
    case .lRoot:
        
        switch action {
        case .rUp:
            handControlRoot.littleFingerRootRotateUp()
        case .rDown:
            handControlRoot.littleFingerRootRotateDown()
        default:
            print("\(handPart) \(action) is in valid.")
            break
        }
    case .tSelf:
        
        switch action {
        case .rUp:
            handControlRoot.thumbSelfRotateUp()
        case .rDown:
            handControlRoot.thumbSelfRotateDown()
        default:
            print("\(handPart) \(action) is in valid.")
            break
        }
    case .iSelf:
        
        switch action {
        case .rUp:
            handControlRoot.indexFingerSelfRotateUp()
        case .rDown:
            handControlRoot.indexFingerSelfRotateDown()
        default:
            print("\(handPart) \(action) is in valid.")
            break
        }
    case .mSelf:
        
        switch action {
        case .rUp:
            handControlRoot.middleFingerSelfRotateUp()
        case .rDown:
            handControlRoot.middleFingerSelfRotateDown()
        default:
            print("\(handPart) \(action) is in valid.")
            break
        }
    case .rSelf:
        
        switch action {
        case .rUp:
            handControlRoot.ringFingerSelfRotateUp()
        case .rDown:
            handControlRoot.ringFingerSelfRotateDown()
        default:
            print("\(handPart) \(action) is in valid.")
            break
        }
    case .lSelf:
        
        switch action {
        case .rUp:
            handControlRoot.littleFingerSelfRotateUp()
        case .rDown:
            handControlRoot.littleFingerSelfRotateDown()
        default:
            print("\(handPart) \(action) is in valid.")
            break
        }
    case .tHBRoot:
        
        switch action {
        case .rUp:
            handControlRoot.thumbBoneRotateUp()
        case .rDown:
            handControlRoot.thumbBoneRotateDown()
        default:
            print("\(handPart) \(action) is in valid.")
            break
        }
    case .wrist:
        switch action {
        case .rUp:
            handControlRoot.wristJointRotateUp()
        case .rDown:
            handControlRoot.wristJointRotateDown()
        case .rLeft:
            handControlRoot.wristJointRotateLeft()
        case .rRight:
            handControlRoot.wristJointRotateRight()
        default:
            print("\(handPart) \(action) is in valid.")
            break
        }
    case .arm:
        switch action {
        case .rUp:
            handControlRoot.handJointRotateUp()
        case .rDown:
            handControlRoot.handJointRotateDown()
        case .rLeft:
            handControlRoot.handJointRotateLeft()
        case .rRight:
            handControlRoot.handJointRotateRight()
        case .sRLeft:
            handControlRoot.handJointSelfRotateLeft()
        case .sRRight:
            handControlRoot.handJointSelfRotateRight()
        case .mForward:
            handControlRoot.handMoveForward()
        case .mBack:
            handControlRoot.handMoveBack()
        case .mLeft:
            handControlRoot.handMoveLeft()
        case .mRight:
            handControlRoot.handMoveRight()
        case .mUp:
            handControlRoot.handMoveUp()
        case .mDown:
            handControlRoot.handMoveDown()
//        default:
//            print("\(handPart) \(action) is in valid.")
//            break
        }
    }
}
