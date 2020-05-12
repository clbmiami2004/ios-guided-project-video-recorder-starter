//
//  CameraViewController.swift
//  VideoRecorder
//
//  Created by Paul Solt on 10/2/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    @IBOutlet var recordButton: UIButton!
    @IBOutlet var cameraView: CameraPreviewView!


	override func viewDidLoad() {
		super.viewDidLoad()

		// Resize camera preview to fill the entire screen
		cameraView.videoPlayerLayer.videoGravity = .resizeAspectFill
	}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestPermissionAndShowCamera()
    }
    
    private func requestPermissionAndShowCamera() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            return requestVideoPermission()
        case .restricted:
            preconditionFailure("Video is disabled, please review device restrictions")
        case .denied:
            preconditionFailure("Tell the user they can't use the app without giving permissions via Settings > Privacy > Video")
        case .authorized:
            showCamera()
        @unknown default:
            preconditionFailure("A new status code was added that we need to handle")
        }
    }

    private func requestVideoPermission() {
        AVCaptureDevice.requestAccess(for: .video) { (isGranted) in
            guard isGranted else {
                preconditionFailure("UI: Tell the user to enable permissions for Video/Camera")
            }
            
            DispatchQueue.main.async {
                self.showCamera()
            }
        }
    }
    
    private func showCamera() {
        
    }

    @IBAction func recordButtonPressed(_ sender: Any) {

	}
	
	/// Creates a new file URL in the documents directory
	private func newRecordingURL() -> URL {
		let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

		let formatter = ISO8601DateFormatter()
		formatter.formatOptions = [.withInternetDateTime]

		let name = formatter.string(from: Date())
		let fileURL = documentsDirectory.appendingPathComponent(name).appendingPathExtension("mov")
		return fileURL
	}
}

