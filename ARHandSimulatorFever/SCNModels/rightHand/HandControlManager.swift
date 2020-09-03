//
//  handControlManager.swift
//  ARHandSimulatorFever
//
//  Created by Kagamigawa on 2020/04/28.
//  Copyright © 2020 JohnBo. All rights reserved.
//

import Foundation

extension MainViewController {
    
    class HandControlManager {
        private var handControlRoot: RightHand
        private var debugMode: DebugMode
        private let defaultHandPartsWithValidActions: [HandPartFlag : [ActionFlag]]
        let sessionStateWithValidHandParts: [SessionState : [HandPartFlag]]
        
        let fingersActions = [ActionFlag.rUp, ActionFlag.rDown]
        let wirstActions = [ActionFlag.rUp, ActionFlag.rDown, ActionFlag.rLeft, ActionFlag.rRight]
        let armActions = [ActionFlag.rUp, ActionFlag.rDown, ActionFlag.rLeft, ActionFlag.rRight, ActionFlag.sRLeft, ActionFlag.sRRight, ActionFlag.mForward, ActionFlag.mBack, ActionFlag.mLeft, ActionFlag.mRight, ActionFlag.mUp, ActionFlag.mDown]
        
        let fingerParts = [HandPartFlag.iRoot,HandPartFlag.tRoot,HandPartFlag.mRoot,HandPartFlag.rRoot,HandPartFlag.lRoot,HandPartFlag.tSelf,HandPartFlag.tHBRoot,HandPartFlag.iSelf,HandPartFlag.mSelf,HandPartFlag.rSelf,HandPartFlag.lSelf]
        let wristPart = [HandPartFlag.wrist]
        let armPart = [HandPartFlag.arm]
        
        init(handControlRoot: inout RightHand, sessionState: SessionState, menuStatus: MenuStatus, debugMode: DebugMode) {
            self.handControlRoot = handControlRoot
            self.debugMode = debugMode
            
            var defaultHandPartsWithValidActionsDictionary: [HandPartFlag : [ActionFlag]] = [:]
            defaultHandPartsWithValidActionsDictionary.updateValue(fingersActions, forKey: .tRoot)
            defaultHandPartsWithValidActionsDictionary.updateValue(fingersActions, forKey: .iRoot)
            defaultHandPartsWithValidActionsDictionary.updateValue(fingersActions, forKey: .mRoot)
            defaultHandPartsWithValidActionsDictionary.updateValue(fingersActions, forKey: .rRoot)
            defaultHandPartsWithValidActionsDictionary.updateValue(fingersActions, forKey: .lRoot)
            defaultHandPartsWithValidActionsDictionary.updateValue(fingersActions, forKey: .tSelf)
            defaultHandPartsWithValidActionsDictionary.updateValue(fingersActions, forKey: .iSelf)
            defaultHandPartsWithValidActionsDictionary.updateValue(fingersActions, forKey: .mSelf)
            defaultHandPartsWithValidActionsDictionary.updateValue(fingersActions, forKey: .rSelf)
            defaultHandPartsWithValidActionsDictionary.updateValue(fingersActions, forKey: .lSelf)
            defaultHandPartsWithValidActionsDictionary.updateValue(fingersActions, forKey: .tHBRoot)
            defaultHandPartsWithValidActionsDictionary.updateValue(wirstActions, forKey: .wrist)
            defaultHandPartsWithValidActionsDictionary.updateValue(armActions, forKey: .arm)
            defaultHandPartsWithValidActions = defaultHandPartsWithValidActionsDictionary
            
            var sessionHandDictionary: [SessionState : [HandPartFlag]] = [:]
            sessionHandDictionary.updateValue([], forKey: .setup)
            sessionHandDictionary.updateValue([], forKey: .lookingForSurface)
            sessionHandDictionary.updateValue([], forKey: .placingBoard)
            sessionHandDictionary.updateValue([], forKey: .buildingWorld)
            sessionHandDictionary.updateValue([], forKey: .setupLevel)
            sessionHandDictionary.updateValue(fingerParts + wristPart + armPart, forKey: .gameInProgress)
            sessionHandDictionary.updateValue(fingerParts + wristPart + armPart, forKey: .cachingThings)
            sessionHandDictionary.updateValue(wristPart + armPart, forKey: .readyToThrowOut)
            sessionHandDictionary.updateValue([], forKey: .ballIsThrewOut)
            sessionHandDictionary.updateValue([], forKey: .stageClear)
            sessionStateWithValidHandParts = sessionHandDictionary
        }
        
        func validHandPartsAndActions(inState nowState: SessionState) -> [HandPartFlag : [ActionFlag]] {
            var validHandPartsWithValidActions: [HandPartFlag : [ActionFlag]] = [:]
            let validHandParts = sessionStateWithValidHandParts[nowState]!
            
            for i in validHandParts {
                validHandPartsWithValidActions.updateValue(defaultHandPartsWithValidActions[i]!, forKey: i)
            }
            
            return validHandPartsWithValidActions
        }
        
        func make(_ handPart: HandPartFlag, _ action: ActionFlag) {
            convertEnumToFunc(handControlRoot: &handControlRoot, handPart, action)
        }
    }
    
}

