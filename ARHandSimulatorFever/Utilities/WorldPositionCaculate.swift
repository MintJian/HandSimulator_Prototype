//
//  WorldPositionCaculate.swift
//  ARHandSimulatorFever
//
//  Created by Kagamigawa on 2020/04/22.
//  Copyright © 2020 JohnBo. All rights reserved.
//

import Foundation
import SceneKit
import CoreMotion

func distance(_ a: SCNVector3, _ b: SCNVector3) -> Float {
    return sqrt(abs(a.x - b.x) * abs(a.x - b.x) + abs(a.x - b.x) * abs(a.y - b.y) + abs(a.z - b.z) * abs(a.z - b.z))
}

func accleration3Value(_ accleration: CMAcceleration) -> Double {
    return sqrt(accleration.x * accleration.x + accleration.y * accleration.y + accleration.z)
}
