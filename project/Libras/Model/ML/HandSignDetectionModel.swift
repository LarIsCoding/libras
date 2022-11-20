//
//  HandSignDetectionModel.swift
//  Libras
//
//  Created by Larissa Gomes de Stefano Escaliante on 18/08/22.
//

import Foundation
import Vision

class HandSignDetectionModel {

    var model: Libras?

    init() {
        do {
            let config = MLModelConfiguration()
            model = try Libras(configuration: config)
        } catch {
            print("Cannot load model")
        }
    }

    func detectHandSign(_ buffer: CVPixelBuffer) -> LibrasOutput? {
        guard let handPose = getHandPose(buffer) else { return nil }
        return predictHandSign(handPose)
    }

    private func getHandPose(_ buffer: CVPixelBuffer) -> MLMultiArray? {
        let handPoseRequest = createRequest()
        guard let handPoseObservation = getFirstHandPoseObservation(buffer: buffer, request: handPoseRequest) else { return nil }

        guard let handPoseMultiArray = try? handPoseObservation.keypointsMultiArray() else {
            print("Failed in get Hand Pose MLMultiArray entry")
            return nil
        }
        return handPoseMultiArray
    }

    private func createRequest() -> VNDetectHumanHandPoseRequest {
        let handPoseRequest = VNDetectHumanHandPoseRequest()
        handPoseRequest.maximumHandCount = 1
        handPoseRequest.revision = VNDetectHumanHandPoseRequestRevision1
        return handPoseRequest
    }

    private func getFirstHandPoseObservation(buffer: CVPixelBuffer, request: VNDetectHumanHandPoseRequest) -> VNHumanHandPoseObservation? {
        let handler = VNImageRequestHandler(cvPixelBuffer: buffer, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("Hand Pose Request Failed")
            return nil
        }

        guard let handPoses = request.results, !handPoses.isEmpty else { return nil }
        return handPoses.first
    }

    private func predictHandSign(_ handPose: MLMultiArray) -> LibrasOutput? {
        do {
            let handSignPrediction = try model!.prediction(poses: handPose)
            return handSignPrediction
        } catch {
            print("Failed in Predicting Hand Sign")
            return nil
        }
    }
}
