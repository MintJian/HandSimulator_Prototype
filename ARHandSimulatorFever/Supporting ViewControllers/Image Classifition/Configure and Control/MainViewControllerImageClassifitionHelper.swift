//
//  MainViewControllerImageClassifitionHelper.swift
//  ARHandSimulatorFever
//
//  Created by Kagamigawa on 2020/04/28.
//  Copyright © 2020 JohnBo. All rights reserved.
//

import UIKit
import Accelerate
import Vision
import ImageIO

extension MainViewController {
    
    func updateClassifications(for image: UIImage) {
        print("Classifying...")
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage)
            
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                print("Unable to classify image.\n\(error!.localizedDescription)")
                return
            }
            let classifications = results as! [VNClassificationObservation]
            
            if classifications.isEmpty {
                print("Nothing recognized.")
            } else {
                let topClassifications = classifications.prefix(2)
                let descriptions = topClassifications.map { classification in
                    return String(format: "  (%.2f) %@", classification.confidence, classification.identifier)
                }
                print(descriptions.first!)
                let result: String = descriptions.first ?? "none"
                let usefulResult = result.split(separator: " ").last!
                
                self.handGesture = HandGesture(rawValue: String(usefulResult))!
                print("Classification:\n" + descriptions.joined(separator: "\n"))
            }
        }
    }
    
    
    @objc
    func classifyHandGesture() {
        guard (sessionState == .gameInProgress || sessionState == .cachingThings || sessionState == .readyToThrowOut) else {
            print("mlModel is called in wrong time.")
            return
        }
        autoreleasepool{
            guard let currentFrame = sceneView.session.currentFrame else {  print("Can't get current frame.");return }
            let picture = currentFrame.capturedImage
            let ciImage = CIImage(cvPixelBuffer: picture)
            let temporaryContext = CIContext(options: nil)
            let pic = temporaryContext.createCGImage(ciImage, from: CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(picture), height: CVPixelBufferGetHeight(picture)))!
            
            let image = createModelFitImage(for: UIImage(cgImage: pic))
            updateClassifications(for: image)
        }
    }
    
    func createModelFitImage(for image: UIImage) -> UIImage {
        var orien = UIImage.Orientation.up
        if image.size.width < image.size.height {
            orien = .left
        }
        
        let scaleRatio = 480.0 / max(image.size.width, image.size.height)
        let resizedImage = UIImage(cgImage: image.cgImage!, scale: scaleRatio, orientation: orien)
        
        return resizedImage
    }
    
}
