//
//  FrameManager.swift
//  Libras
//
//  Created by Larissa Gomes de Stefano Escaliante on 16/08/22.
//

import AVFoundation
import CoreML
import Vision

class HandSignManager: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {

    static let shared = HandSignManager()
    let model = HandSignDetectionModel()
    var detectionCallback: ((String) -> Void)?

    var lastDetectedSign = ""
    var lastDetectedSignStreak = 0

    let videoOutputQueue = DispatchQueue(
        label: "com.example.VideoOutputQ",
        qos: .userInitiated,
        attributes: [],
        autoreleaseFrequency: .workItem
    )

    private override init() {
        super.init()
        CameraManager.shared.setDelegate(self, queue: videoOutputQueue)
    }

    func setDetectionCallback(_ callbackFunction: @escaping ((String) -> Void)) {
        self.detectionCallback = callbackFunction
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let buffer = sampleBuffer.imageBuffer else { return }
        guard let handSignPrediction = model.detectHandSign(buffer) else { return }
        updateHandSignState(handSignPrediction)
        
        if lastDetectedSignStreak >= 50 {
            print("\(lastDetectedSign) was detected")
            lastDetectedSignStreak = 0
            detectionCallback?(lastDetectedSign)
        }
    }

    private func updateHandSignState(_ handSignPrediction: LibrasOutput) {
//        let confidence = handSignPrediction.labelProbabilities[handSignPrediction.label]
        print(handSignPrediction.label)
        if handSignPrediction.label == lastDetectedSign {
            lastDetectedSignStreak += 1
        } else {
            lastDetectedSignStreak = 0
            lastDetectedSign = handSignPrediction.label
        }
    }
}
