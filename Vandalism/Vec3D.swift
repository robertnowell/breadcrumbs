//
//  Vec3D.swift
//  Vandalism
//
//  Created by Prateek R Patil on 11/5/16.
//  Copyright © 2016 Prateek R Patil. All rights reserved.
//

import Foundation

class Vec3D {
    
    var x : Float = 0;
    var y : Float = 0;
    var z : Float = 0;
    
    static let UnitVectorX = Vec3D(x: 1.0, y: 0, z: 0);
    static let UnitVectorY = Vec3D(x: 0, y: 1.0, z: 0);
    static let UnitVectorZ = Vec3D(x: 0, y: 0, z: 1.0);
    
    init() {
        self.x = 0;
        self.y = 0;
        self.z = 0;
    }
    
    init(x: Float, y: Float, z: Float) {
        self.x = x;
        self.y = y;
        self.z = z;
    }
    
    func length() -> Float {
        return sqrtf(self.x * self.x + self.y * self.y + self.z * self.z);
    }
    
    func normalize() -> Vec3D {
        let len = self.length();
        return Vec3D(x: self.x / len, y: self.y / len, z: self.z / len);
    }
    
    func scale(scalar: Float) -> Vec3D {
        return Vec3D(x: self.x * scalar, y: self.y * scalar, z: self.z * scalar);
    }
    
    static prefix func -(right: Vec3D) -> Vec3D {
        return right.scale(scalar: -1.0);
    }
    
    static func +(left: Vec3D, right: Vec3D) -> Vec3D {
        return Vec3D(x: left.x + right.x, y: left.y + right.y, z: left.z + right.z);
    }
    
    static func *(left: Vec3D, right: Vec3D) -> Float {
        return left.x * right.x + left.y * right.y + left.z * right.z;
    }
    
    static func ^(left: Vec3D, right: Vec3D) -> Vec3D { //Cross Product;
        return Vec3D(x: left.y * right.z - left.z * right.y, y: left.x * right.z - left.z * right.x, z: left.x * right.y - left.y - right.x);
    }
    
    static func rotate(v: Vec3D, a: Vec3D, r: Float) -> Vec3D {
        return v.scale(scalar: cosf(r)) + (a ^ v).scale(scalar: sinf(r)) + a.scale(scalar: (a * v) * (1 - cosf(r)));
    }
    
    func projectionPlot(focalLength: Float) -> Vec2D {
        return Vec2D(i: self.x * focalLength / self.z, j: self.y * focalLength / self.z);
    }
}
