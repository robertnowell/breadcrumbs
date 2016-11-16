//
//  PointTracker.swift
//  Vandalism
//
//  Created by Prateek R Patil on 11/5/16.
//  Copyright © 2016 Prateek R Patil. All rights reserved.
//

import Foundation
import CoreMotion
import UIKit

let x_axis = CMQuaternion(x: 1, y: 0, z: 0, w: 0);
let y_axis = CMQuaternion(x: 0, y: 1, z: 0, w: 0);
let z_axis = CMQuaternion(x: 0, y: 0, z: 1, w: 0);
let no_vec = CMQuaternion(x: 0, y: 0, z: 0, w: 0);

func crossVec(v1 : CMQuaternion, v2 : CMQuaternion) -> CMQuaternion {
    var r = CMQuaternion();
    r.x = v1.y * v2.z - v1.z * v2.y;
    r.y = v1.x * v2.z - v1.z * v2.x;
    r.z = v1.x * v2.y - v1.y * v2.x;
    return r;
}

func addVec(v1 : CMQuaternion, v2 : CMQuaternion) -> CMQuaternion {
    var r = CMQuaternion();
    r.x = v1.x + v2.x;
    r.y = v1.y + v2.y;
    r.z = v1.z + v2.z;
    return r;
}

func scaleVec(v1 : CMQuaternion, s : Double) -> CMQuaternion {
    var r = CMQuaternion();
    r.x = v1.x * s;
    r.y = v1.y * s;
    r.z = v1.z * s;
    return r;
}

func dotVec(v1 : CMQuaternion, v2 : CMQuaternion) -> Double {
    return (v1.x * v2.x + v1.y * v2.y + v1.z * v2.z);
}

func rotateVec(v : CMQuaternion, k: CMQuaternion, rads : Double) -> CMQuaternion {
    let p1 = scaleVec(v1: v, s: cos(rads));
    let p2 = scaleVec(v1: crossVec(v1: k, v2: v), s: sin(rads));
    let p3 = scaleVec(v1: k, s: dotVec(v1: k, v2: v) * (1 - cos(rads)));
    let q = addVec(v1: p1, v2: addVec(v1: p2, v2: p3));
    return q;
}

class PointTracker {
    let manager : CMMotionManager = CMMotionManager();
    let operationQueue: OperationQueue = OperationQueue();
    var rot = CMQuaternion(x: 0, y: 0, z: 0, w: 0);
    var q = CMQuaternion(x: 0, y: 0, z: -10, w: 0);
    var	thingy : UIView? = nil;
    var parentView : UIView? = nil;
    
    init() {
        self.operationQueue.qualityOfService = .userInteractive;
        manager.deviceMotionUpdateInterval = TimeInterval(1 / 60.0);
        manager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: self.operationQueue, withHandler: {
            motion, err in
            
            var r = rotateVec(v: self.q, k: x_axis, rads: -((motion?.attitude.pitch)!));
            r = rotateVec(v: r, k: y_axis, rads: -((motion?.attitude.roll)!));
            r = rotateVec(v: r, k: z_axis, rads: -(motion?.attitude.yaw)!);
            //print(motion?.attitude.roll, motion?.attitude.pitch, motion?.attitude.yaw);
            if (self.thingy != nil && self.parentView != nil && r.z != 0) {
                let h = self.parentView?.frame.height;
                let newx : Int = (Int)(h! * (CGFloat)(0.5 + (r.x * 5.0 / -r.z) * 0.5)) - (Int)((self.parentView?.frame.width)! / 2);
                let newy : Int = (Int)(h! * (CGFloat)(0.5 + (r.y * 5.0 / -r.z) * 0.5));
                //print(newx, newy);
                OperationQueue.main.addOperation({
                    _ in
                    self.thingy?.frame.origin = CGPoint(x: newx, y: newy);
                });
            }
        });
    }
}
