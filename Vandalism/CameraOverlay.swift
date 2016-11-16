//
//  CameraOverlay.swift
//  Vandalism
//
//  Created by Prateek R Patil on 11/4/16.
//  Copyright © 2016 Prateek R Patil. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class CameraOverlay: UIView {
    
    let videoDeviceList = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo);
    let videoSession : AVCaptureSession = AVCaptureSession();
    
    var	videoDevice : AVCaptureDevice? = nil;
    var videoPreviewLayer : AVCaptureVideoPreviewLayer? = nil;
    
    func _getCaptureDevice() {
        for d in self.videoDeviceList! {
            let d = d as! AVCaptureDevice;
            if (d.position == .back) {
                self.videoDevice = d;
                break;
            }
        }
        if (self.videoDevice != nil) {
            var input : AVCaptureDeviceInput? = nil;
            do {
                input = try AVCaptureDeviceInput(device: self.videoDevice);
            } catch _ as NSError {
                debugPrint("FATAL ERROR: Failed to get capture input!");
                return;
            }
            self.videoSession.addInput(input);
        }
    }
    
    func _getVideoPreviewLayer(){
        if (self.videoSession.inputs.count == 1) {
            self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.videoSession);
            self.videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill;
            self.layer.addSublayer(self.videoPreviewLayer!);
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.frame = frame;
        self._getCaptureDevice();
        self._getVideoPreviewLayer();
        self.videoPreviewLayer?.frame = frame;
        self.videoPreviewLayer?.bounds = frame;
        self.videoSession.startRunning();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
}
