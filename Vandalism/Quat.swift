//
//  Quat.swift
//  Vandalism
//
//  Created by Prateek R Patil on 11/6/16.
//  Copyright © 2016 Prateek R Patil. All rights reserved.
//

import Foundation
import CoreMotion

class Quat {
    
    var w : Float = 0;
    var v = Vec3D();
    
    init() {
        //
    }
    
    init(w: Float, x: Float, y: Float, z: Float) {
        self.w = w;
        self.v.x = x;
        self.v.y = y;
        self.v.z = z;
    }
    
    init(v: Vec3D, a: Float) {
        self.v = v.scale(scalar: sinf(a / 2));
        self.w = cosf(a / 2);
    }
    
    func invert() -> Quat {
        let q = Quat();
        q.v = -self.v;
        q.w = self.w;
        return q;
    }
    
    static func *(left: Quat, right: Quat) -> Quat {
        let r = Quat();
        r.w = left.w * right.w + left.v * right.v;
        r.v = left.v.scale(scalar: right.w) + right.v.scale(scalar: left.w) + (left.v ^ right.v);
        return r;
    }
    
    static func *(left: Quat, right: Vec3D) -> Vec3D {
        let p = Quat();
        p.w = 0;
        p.v = right;
        let r = left.v ^ right;
        return (p.v + r.scale(scalar: left.w * 2) + (left.v ^ r).scale(scalar: 2));
    }
}
