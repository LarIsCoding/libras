//
//  CameraManager.swift
//  Libras
//
//  Created by Larissa Gomes de Stefano Escaliante on 16/08/22.
//

import AVFoundation

class CameraManager {

    enum Status {
        case unconfigured
        case configured
        case unauthorized
        case failed
    }

    var status = Status.unconfigured

    let session = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "com.example.sessionQ")
    private let videoOutput = AVCaptureVideoDataOutput()

    static let shared = CameraManager()

    private init() {
        configure()
    }

    private func configure() {
        checkPermissions()
        sessionQueue.async {
            self.configureCamera()
            self.session.startRunning()
        }
    }

    private func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            sessionQueue.suspend()
            AVCaptureDevice.requestAccess(for: .video) { authorized in
                if !authorized {
                    self.status = .unauthorized
                }
                self.sessionQueue.resume()
            }
        case .restricted:
            status = .unauthorized
        case .denied:
            status = .unauthorized
        case .authorized:
            break
        @unknown default:
            status = .unauthorized
        }
    }

    private func configureCamera() {
        guard status == .unconfigured else { return }

        session.beginConfiguration()

        guard let device = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: .front
        ) else {
            print("Device não foi encontrado")
            status = .failed
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: device)

            if session.canAddInput(input) {
                session.addInput(input)
            } else {
                status = .failed
                return
            }

            if session.canAddOutput(videoOutput) {
                session.addOutput(videoOutput)
            } else {
                status = .failed
                return
            }

            let connection = videoOutput.connection(with: AVMediaType.video)
            connection?.videoOrientation = .portrait

            session.commitConfiguration()
            status = .configured

        } catch {
            print("Input da camera não conseguiu ser configurado")
            print(error.localizedDescription)
        }
    }

    func setDelegate(
        _ delegate: AVCaptureVideoDataOutputSampleBufferDelegate,
        queue: DispatchQueue
    ) {
        sessionQueue.async {
            self.videoOutput.setSampleBufferDelegate(delegate, queue: queue)
        }
    }
}
