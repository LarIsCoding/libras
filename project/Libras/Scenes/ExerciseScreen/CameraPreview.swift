//
//  CameraPreview.swift
//  Libras
//
//  Created by Larissa Gomes de Stefano Escaliante on 16/08/22.
//

import AVFoundation
import SwiftUI

struct CameraPreview: UIViewRepresentable {

    func makeUIView(context _: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        let preview = AVCaptureVideoPreviewLayer(session: CameraManager.shared.session)
        preview.frame = view.frame
        preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(preview)
        if CameraManager.shared.status == .configured {
            CameraManager.shared.session.startRunning()
        }
        return view
    }

    func dismantleUIView(_: Self.UIViewType, coordinator: Self.Coordinator) {
        CameraManager.shared.session.stopRunning()
    }

    func updateUIView(_: UIView, context _: Context) {}
}
