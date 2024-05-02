//
//  CameraHelper.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/18/24.
//

import AVFoundation

func checkCameraPermissions(completion: @escaping (Bool) -> Void) {
    switch AVCaptureDevice.authorizationStatus(for: .video) {
    case .authorized:
        completion(true)
    case .notDetermined:
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    default:
        completion(false)
    }
}
