//
//  Vec2D.swift
//  Vandalism
//
//  Created by Prateek R Patil on 11/5/16.
//  Copyright © 2016 Prateek R Patil. All rights reserved.
//

import Foundation

class Vec2D {
    
    var i : Float = 0;
    var j : Float = 0;
    
    init() {
        //Meh
    }
    
    init(i: Float, j: Float) {
        self.i = i;
        self.j = j;
    }
    
    func normalize() -> Vec2D {
        let len = self.length();
        return Vec2D(i: self.i / len, j: self.j / len);
    }
    
    func length() -> Float {
        return sqrtf(self.i * self.i + self.j * self.j);
    }
    
    func scale(scalar: Float) -> Vec2D {
        return Vec2D(i: self.i * scalar, j: self.j * scalar);
    }
    
    static prefix func -(right: Vec2D) -> Vec2D {
        return right.scale(scalar: -1.0);
    }
    
    static func +(left: Vec2D, right: Vec2D) -> Vec2D {
        return Vec2D(i: left.i + right.i, j: left.j + right.j);
    }
    
    static func *(left: Vec2D, right: Vec2D) -> Float {
        return left.i * right.i + left.j * right.j;
    }
    
    static func rotate(v: Vec2D, r: Float) -> Vec2D {
        return Vec2D(i: v.i * cosf(r) - v.j * sinf(r), j: v.i * sinf(r) - v.j * cosf(r));
    }
}
